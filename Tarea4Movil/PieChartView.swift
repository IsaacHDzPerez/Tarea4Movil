//
//  PieChartView.swift
//  Tarea4Movil
//
//  Created by Alumno on 27/09/24.
//


import SwiftUI

struct PieChartView: View {
    @State var slices: [(Double, Color, String)] = [
        (20, .blue, "Real Madrid"),
        (30, .red, "Barcelona"),
        (30, .green, "Atlético Madrid"),
        (10, .orange, "Sevilla")
    ]
    @State var isDonut = false
    @State var hasGap = false
    @EnvironmentObject var userSettings: UserSettings

    var body: some View {
        ZStack {
           
            Color(userSettings.backgroundColor)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Gráfica de Pastel - % de victorias")
                    .font(.title)
                    .padding(.top, 20)
                    .foregroundColor(.black)

                Canvas { context, size in
                    let total = slices.reduce(0) { $0 + $1.0 }
                    context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                    var pieContext = context
                    pieContext.rotate(by: .degrees(-90))
                    let radius = min(size.width, size.height) * 0.48
                    var startAngle = Angle.zero
                    let gapSize = Angle(degrees: 5)

                    for (value, color, _) in slices {
                        let angle = Angle(degrees: 360 * (value / total))
                        let endAngle = startAngle + angle

                        let path = Path { p in
                            p.move(to: .zero)
                            if hasGap {
                                p.addArc(center: .zero, radius: radius, startAngle: startAngle + gapSize / 2, endAngle: endAngle, clockwise: false)
                            } else {
                                p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                            }
                            p.closeSubpath()
                        }
                        pieContext.fill(path, with: .color(color))
                        startAngle = endAngle
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .padding(.top, 20)

                VStack(alignment: .leading) {
                    ForEach(0..<slices.count, id: \.self) { i in
                        let slice = slices[i]
                        HStack {
                            Circle()
                                .fill(slice.1)
                                .frame(width: 15, height: 15)
                            Text("\(slice.2) - \(Int(slice.0))%")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)
                        }
                    }
                }
             
            }
        }
   
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
            .environmentObject(UserSettings())
    }
}

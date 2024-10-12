//
//  LineChartDetailView.swift
//  Tarea4Movil
//
//  Created by Alumno on 30/09/24.
//
import SwiftUI
import Charts

struct LineChartDetailView: View {
    @State var teamPerformance: [(String, [Double], Color)] = [
        ("Real Madrid", [3, 2, 4, 3, 5, 3], .blue),
        ("Barcelona", [4, 3, 3, 4, 5, 4], .red),
        ("Atlético Madrid", [2, 3, 2, 4, 3, 5], .green),
        ("Sevilla", [1, 2, 3, 1, 2, 1], .orange)
    ]
    
    @EnvironmentObject var userSettings: UserSettings

    var body: some View {
        ZStack {
            Color(userSettings.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Desempeño por Jornada - LaLiga")
                    .font(.title)
                    .padding(.top, 20)
                    .foregroundColor(userSettings.textColor)
                
                Chart {
                    ForEach(0..<teamPerformance.count, id: \.self) { index in
                        let team = teamPerformance[index]
                        ForEach(0..<team.1.count, id: \.self) { jornada in
                            LineMark(
                                x: .value("Jornada", jornada),
                                y: .value("Puntos", team.1[jornada])
                            )
                            .foregroundStyle(team.2)
                        }
                        .interpolationMethod(.cardinal)
                        .symbol(by: .value("Team", team.0))
                        .lineStyle(StrokeStyle(lineWidth: 2))
                    }
                }
                .frame(height: 300)
                .padding()
                
                VStack(alignment: .leading) {
                    ForEach(0..<teamPerformance.count, id: \.self) { i in
                        let team = teamPerformance[i]
                        HStack {
                            Circle()
                                .fill(team.2)
                                .frame(width: 15, height: 15)
                            Text(team.0)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(userSettings.textColor)
                        }
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

struct LineChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartDetailView()
            .environmentObject(UserSettings()) 
    }
}

//
//  ChartListView.swift
//  Tarea4Movil
//
//  Created by Alumno on 27/09/24.
//
import SwiftUI

struct ChartListView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            Color(userSettings.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                List {
                    NavigationLink(destination: PieChartView()) {
                        Text("Gráfico de Pastel")
                    }
                    NavigationLink(destination: BarChartDetailView()) {
                        Text("Gráfico de Barras")
                    }
                    NavigationLink(destination: LineChartDetailView()) {
                        Text("Gráfico de Líneas")
                    }
                    NavigationLink(destination: AreaChartView()) {
                        Text("Gráfico de Áreas")
                    }
                }
                .navigationTitle("Gráficas")
                .foregroundColor(userSettings.textColor)
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct ChartListView_Previews: PreviewProvider {
    static var previews: some View {
        ChartListView()
            .environmentObject(UserSettings()) 
    }
}

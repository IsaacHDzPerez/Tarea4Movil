//
//  AreaChartView.swift
//  Tarea4Movil
//
//  Created by Alumno on 30/09/24.
//
import SwiftUI
import Charts

struct AreaChartView: View {
    @StateObject var viewModel = TeamPerformanceViewModel()
    @EnvironmentObject var userSettings: UserSettings


    var body: some View {
        ZStack {
            Color(userSettings.backgroundColor).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Gráfico de Áreas - Desempeño de Clubes")
                    .font(.title2)
                    .padding(.top, 20)
                
                if viewModel.teamPerformances.isEmpty {
                    ProgressView("Cargando datos...")
                        .frame(height: 300)
                        .padding()
                } else {
                    Chart {
                        ForEach(viewModel.teamPerformances) { performance in
                            AreaMark(
                                x: .value("Mes", performance.month),
                                y: .value("Valor", performance.value),
                                stacking: .standard 
                            )
                            .foregroundStyle(by: .value("Equipo", performance.team))
                        }
                    }
                    .frame(height: 300)
                    .padding()
                    .chartLegend(position: .bottom)
                }
            }
            .padding()
            .onAppear {
                viewModel.loadData()
            }
           
        }
        
    }
}

struct AreaChartView_Previews: PreviewProvider {
    static var previews: some View {
        AreaChartView()
    }
}




//
//  BarChartDetailView.swift
//  Tarea4Movil
//
//  Created by Alumno on 27/09/24.
//
import SwiftUI
import Charts
import Firebase


struct BarChartDetailView: View {
    @EnvironmentObject var userSettings: UserSettings
    @StateObject var viewModel = TeamPerformanceViewModel()
    
    /*let db = Firestore.firestore()

    let data: [TeamGoals] = [
        TeamGoals(team: "Real Madrid", goals: 67),
        TeamGoals(team: "Barcelona", goals: 83),
        TeamGoals(team: "Atlético Madrid", goals: 79),
        TeamGoals(team: "Sevilla", goals: 65)
    ]
     */
    
    var body: some View {
        ZStack {
            Color(userSettings.backgroundColor).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Goles por Equipo - Temporada 2024")
                    .font(.title)
                    .foregroundColor(userSettings.textColor)
                    .padding()
                
                Chart {
                    ForEach(viewModel.teamPerformances) { item in
                        BarMark(
                            x: .value("Equipo", item.team),
                            y: .value("Goles", item.goals)
                        )
                        .foregroundStyle(by: .value("Equipo", item.team))
                    }
                }
                .frame(height: 300)
                .padding()
            }
            
            

     
        }
    }
        
}


struct TeamGoals:Codable, Identifiable {
    var id = UUID().uuidString
    var team: String
    var goals: Int
}




struct BarChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let userSettings = UserSettings()
        userSettings.textColor = .black
        userSettings.backgroundColor = .white
        
        return BarChartDetailView()
            .environmentObject(userSettings)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

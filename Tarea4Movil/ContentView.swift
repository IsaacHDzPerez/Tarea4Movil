//
//  ContentView.swift
//  Tarea4Movil
//
//  Created by Alumno on 24/09/24.
//
import SwiftUI
import Firebase


struct ContentView: View {
    @StateObject var userSettings = UserSettings()
    
    var body: some View {
        TabView {
            
           
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
                .environmentObject(userSettings)
                .background(userSettings.backgroundColor)
            
            ChartListView()
                .tabItem {
                    Label("Gráficas", systemImage: "chart.bar")
                }
                .environmentObject(userSettings)
                .background(userSettings.backgroundColor)
            
            SettingsView()
                .tabItem {
                    Label("Ajustes", systemImage: "gearshape")
                }
                .environmentObject(userSettings)
                .background(userSettings.backgroundColor)
        }
        .accentColor(userSettings.textColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14")
            .previewDisplayName("Vista previa del iPhone 14")
    }
}

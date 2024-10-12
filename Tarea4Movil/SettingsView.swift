//
//  SettingsView.swift
//  Tarea4Movil
//
//  Created by Alumno on 27/09/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            
            Color(userSettings.backgroundColor)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Form {
                    Section(header: Text("Ajustes de Color")) {
                        ColorPicker("Color de Fondo", selection: $userSettings.backgroundColor)
                        ColorPicker("Color de Texto", selection: $userSettings.textColor)
                    }
                }
                .navigationTitle("Ajustes")
                .foregroundColor(userSettings.textColor)
                .background(Color.clear)
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserSettings())
    }
}

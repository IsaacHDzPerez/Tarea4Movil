//
//  UserSettingsView.swift
//  Tarea4Movil
//
//  Created by Alumno on 27/09/24.
//

import SwiftUI

class UserSettings: ObservableObject {
    @Published var backgroundColor: Color = .white {
        didSet {
            saveColorToDefaults(color: backgroundColor, key: "backgroundColor")
        }
    }
    
    @Published var textColor: Color = .black {
        didSet {
            saveColorToDefaults(color: textColor, key: "textColor")
        }
    }

    init() {
        loadColors()
    }
    
    private func loadColors() {
        self.backgroundColor = loadColorFromDefaults(key: "backgroundColor") ?? .white
        self.textColor = loadColorFromDefaults(key: "textColor") ?? .black
    }

    private func saveColorToDefaults(color: Color, key: String) {
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(color), requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: key)
        }
    }

    private func loadColorFromDefaults(key: String) -> Color? {
        if let colorData = UserDefaults.standard.data(forKey: key),
           let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
            return Color(uiColor)
        }
        return nil
    }
}

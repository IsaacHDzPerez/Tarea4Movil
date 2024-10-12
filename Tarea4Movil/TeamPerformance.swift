//
//  TeamPerformance.swift
//  Tarea4Movil
//
//  Created by Alumno on 30/09/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore


// Modelo para representar el rendimiento del equipo
struct TeamPerformance: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
    let team: String
    let goals: Int
}

class TeamPerformanceViewModel: ObservableObject {
    @Published var teamPerformances: [TeamPerformance] = []
    let db = Firestore.firestore()

    init() {
        loadData()
    }
    
    func loadData() {
            db.collection("ModelDataCollection").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error al cargar datos: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No se encontraron documentos")
                    return
                }
                
                func addData(teamPerformance: TeamPerformance) {
                        let data: [String: Any] = [
                            "month": teamPerformance.month,
                            "value": teamPerformance.value,
                            "goals": teamPerformance.goals,
                            "team": teamPerformance.team
                        ]
                        
                    self.db.collection("ModelDataCollection").addDocument(data: data) { error in
                            if let error = error {
                                print("Error al agregar documento: \(error)")
                            } else {
                                print("Documento agregado con éxito")
                                self.loadData() 
                            }
                        }
                    }
                
                
                func getData(){
                var listaPendientes: Array<Pendiente> = []
                db.collection("ModelDataCollection").order(by: "nombre").getDocuments{ (querySnapshot, err) in
                if err != nil{
                print("Error en llamada a firebase: \(err!)")
                }else{
                if querySnapshot != nil {
                for documentItem in querySnapshot!.documents{
                let data = documentItem.data()
                let id = documentItem.documentID
                let nombre = data["nombre"] as! String
                let notas = data["notas"] as! String
                let nuevoPendiente = Pendiente(id: id, nombre: nombre, notas: notas)
                listaPendientes.append(nuevoPendiente)
                }
                print(listaPendientes)
                }else{
                print("No hay datos")
                }
                }
                }
                

                self.teamPerformances = documents.compactMap { doc -> TeamPerformance? in
                    let data = doc.data()
                    guard let month = data["month"] as? String,
                          let value = data["value"] as? Double,
                          let goals = data["goals"] as? Int,
                          let team = data["team"] as? String else { return nil }
                    
                    return TeamPerformance(month: month, value: value,team: team, goals: goals)
                }
            }
        }
    
        
        
       /* self.teamPerformances = [
            TeamPerformance(month: "Jan", value: 50, team: "Real Madrid"),
            TeamPerformance(month: "Feb", value: 55, team: "Real Madrid"),
            TeamPerformance(month: "Mar", value: 60, team: "Real Madrid"),
            TeamPerformance(month: "Apr", value: 70, team: "Real Madrid"),
            TeamPerformance(month: "May", value: 80, team: "Real Madrid"),
            TeamPerformance(month: "Jun", value: 90, team: "Real Madrid"),
            
            TeamPerformance(month: "Jan", value: 30, team: "Barcelona"),
            TeamPerformance(month: "Feb", value: 40, team: "Barcelona"),
            TeamPerformance(month: "Mar", value: 50, team: "Barcelona"),
            TeamPerformance(month: "Apr", value: 60, team: "Barcelona"),
            TeamPerformance(month: "May", value: 70, team: "Barcelona"),
            TeamPerformance(month: "Jun", value: 75, team: "Barcelona"),
            
            TeamPerformance(month: "Jan", value: 20, team: "Atlético Madrid"),
            TeamPerformance(month: "Feb", value: 30, team: "Atlético Madrid"),
            TeamPerformance(month: "Mar", value: 40, team: "Atlético Madrid"),
            TeamPerformance(month: "Apr", value: 50, team: "Atlético Madrid"),
            TeamPerformance(month: "May", value: 60, team: "Atlético Madrid"),
            TeamPerformance(month: "Jun", value: 65, team: "Atlético Madrid"),
            
            TeamPerformance(month: "Jan", value: 10, team: "Sevilla"),
            TeamPerformance(month: "Feb", value: 15, team: "Sevilla"),
            TeamPerformance(month: "Mar", value: 20, team: "Sevilla"),
            TeamPerformance(month: "Apr", value: 25, team: "Sevilla"),
            TeamPerformance(month: "May", value: 30, team: "Sevilla"),
            TeamPerformance(month: "Jun", value: 35, team: "Sevilla")
        ]
    }
        
        */
}

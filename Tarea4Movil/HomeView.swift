//
//  HomeView.swift
//  Tarea4Movil
//
//  Created by Alumno on 27/09/24.
//
import SwiftUI



struct HomeView: View {
    @EnvironmentObject var userSettings: UserSettings

    var body: some View {
        ZStack {
                 
            Color(userSettings.backgroundColor).edgesIgnoringSafeArea(.all)

                   VStack {
                       Spacer()
                       
                       
                       Image("Laliga")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 350, height: 350)

                       Spacer().frame(height: 20)

                       
                       Text("Liga Deportiva: LaLiga")
                           .font(.custom("AvenirNext-Bold", size: 36))
                           .foregroundColor(.black)
                           .multilineTextAlignment(.center)
                           .padding(.bottom, 10)
                       
                       Text("Deporte - Fútbol")
                           .font(.custom("AvenirNext-Bold", size: 20))
                           .foregroundColor(.black)
                           .padding(.top, 15)
                   
                       Text("IsaacHDz - Matrícula: A01198674")
                           .font(.custom("HelveticaNeue-Light", size: 20))
                           .foregroundColor(.black)
                           .padding(.top, 15)

                       Spacer()
                   }
                   .padding()
               }
           }
       }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserSettings())
    }
}



//
//  WelcomeView.swift
//  MindFit
//
//  Created by Alexis Jose Palma Ortiz on 18/03/25.
//

import SwiftUI


struct WelcomeView: View {
    @State private var isShowingHabits = false
    @State private var isShowingMedicationView = false
    
    var body: some View {
        NavigationStack {
        ZStack {
            /* Color(red: 141/255, green: 182/255, blue: 0/255).opacity(0.2)

                .ignoresSafeArea()buscar modificaciones para el color */
            
            Image(decorative: "salud")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
                VStack(spacing: 10) {
                    
                    /*/ logo app
                    Image(systemName: "heart") // aqui va el logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red) */
                    
                    // texto de bienvenida
                    Text("MINDFIT")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(
                               LinearGradient(
                                   colors: [.blue, .green],
                                   startPoint: .leading,
                                   endPoint: .trailing
                               )
                           )
                    Text("BIENESTAR FISICO Y MENTAL")
                        .font(.system(size: 20))
                           .fontWeight(.bold)
                           .foregroundStyle(
                                  LinearGradient(
                                      colors: [.blue, .green],
                                      startPoint: .leading,
                                      endPoint: .trailing
                           )
                                  )
                    
                    // Texto de agradecimiento debajo del título
                    Text("App inspired by D'Osmer")
                        .font(.system(size: 15))  // Fuente pequeña
                        .foregroundColor(Color(.green).opacity(0.7)) // Color  para que resalte
                        .padding(.top, 10)  // Distancia desde el título
                        Spacer()
                    
                    
                    // boton para iniciar sesion
                    Button(action: {
                        isShowingHabits = true // aqui redirige a la pantalla
                            
                    }) {
                        Text("Iniciar sesión") // Corregí la capitalización
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(width: 200, height: 40)
                            .background(Color(.green).opacity(0.7))
                            .clipShape(.capsule)
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                          
                    }
                    .navigationDestination(isPresented: $isShowingHabits) {
                        ContentView()
                    }
                    
                } // Cierre de VStack
                .padding()
            } //  Cierre de NavigationStack
        } // Cierre de ZStack
        
    }
}

#Preview {
    WelcomeView()
}

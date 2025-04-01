//
//  ContentView.swift
//  MindFit
//
//  Created by Alexis Jose Palma Ortiz on 16/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HabitViewModel()
    @State private var showingAddHabit = false
    @State private var showingMedicationView = false // vista de medicamentos
    
    var body: some View {
        NavigationView {
            VStack {
                ProgressChartView(
                    completedHabits: viewModel.habits.filter { $0.isCompleted }.count, totalHabits: viewModel.habits.count
                )
                .padding()
                
                // lista de hábitos
                List {
                    ForEach(viewModel.habits) { habit in
                        HStack {
                            Text(habit.name)
                            Spacer()
                            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(habit.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    viewModel.toggleHabitCompletion(habit: habit)
                                }
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteHabit) // para eliminar un hábito
                }
                
                Spacer() // Empuja los botones hacia abajo
                
                // Barra inferior con botones
                HStack {
                    // Botón para agregar hábito
                    Button(action: {
                        showingAddHabit = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 1)
                    }
                    .padding(.leading, 40)
                    
                    Spacer()
                    
                    // Botón para agregar medicamentos
                    Button(action: {
                        showingMedicationView = true // Mostrar vista de medicamentos
                    }) {
                        Image(systemName: "pill.fill") // Ícono de pastilla
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 1)
                    }
                    
                    Spacer()
                    
                    // Botón para eliminar hábitos
                 Button(action: {
                        viewModel.deleteAllHabits() // Llamamos al método para eliminar todos los hábitos
                    }) {
                        Image(systemName: "trash.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 1)
                    }
                    .padding(.trailing, 40)
                }
                .padding(.bottom, 10) // Espacio entre los botones y el borde inferior
            }
            .navigationTitle("Habits")
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(viewModel: viewModel)
            }
            .navigationDestination(isPresented: $showingMedicationView) {
                MedicationView() // Vista de medicamentos
            }
        }
    }
    
    // Eliminar un hábito específico
    func deleteHabit(at offsets: IndexSet) {
        viewModel.habits.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

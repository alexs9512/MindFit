//
//  HabitViewModel.swift
//  MindFit
//
//  Created by Alexis Jose Palma Ortiz on 16/03/25.
//

import Foundation


class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            saveHabits()
        }
    }
    
    // Definimos la clave correctamente como una constante de tipo String
    private let saveKey = "SavedHabits"
    
    init() {
        loadHabits()
        print(" Datos cargados correctamente") // Para verificar que se ejecuta
    }
    
    func addHabit(name: String, category: String) {
        let newHabit = Habit(name: name, category: category, isCompleted: false)
        habits.append(newHabit)
    }
    
    func toggleHabitCompletion(habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompleted.toggle()
        }
    }
    
    // Guardar datos con UserDefaults
    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
            print(" Hábitos guardados correctamente") // Para comprobar que se ejecuta
        }
    }
    
    // Cargar datos con UserDefaults
    private func loadHabits() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: savedData) {
                habits = decoded
            }
        }
    }
    
    func deleteAllHabits() {
        habits.removeAll() // Eliminamos todos los hábitos
        saveHabits() // Guardamos los cambios en UserDefaults
    }

}

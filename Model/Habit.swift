//
//  Habit.swift
//  MindFit
//
//  Created by Alexis Jose Palma Ortiz on 16/03/25.
//

import Foundation


struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var category: String
    var isCompleted: Bool
    
    // Si no se pasa un id, se genera uno nuevo automáticamente
    init(id: UUID = UUID(), name: String, category: String, isCompleted: Bool) {
        self.id = id
        self.name = name
        self.category = category
        self.isCompleted = isCompleted
    }

    // ✅ Permitir decodificación sobrescribiendo el valor inicial
    private enum CodingKeys: String, CodingKey {
        case id, name, category, isCompleted
    }
}


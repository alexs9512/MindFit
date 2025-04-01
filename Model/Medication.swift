//
//  Medication.swift
//  MindFit
//
//  Created by Alexis Jose Palma Ortiz on 18/03/25.
//

import Foundation

struct Medication: Identifiable, Codable {
    let id: UUID
    var name: String
    var dose: String
    var time: Date
    
    // Si no se pasa un id, se genera uno nuevo automáticamente
    init(id: UUID = UUID(), name: String, dose: String, time: Date) {
        self.id = id
        self.name = name
        self.dose = dose
        self.time = time
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, dose, time
    }
}

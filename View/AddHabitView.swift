//
//  AddHabitView.swift
//  MindFit
//
//  Created by Alexis Jose Palma Ortiz on 16/03/25.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitViewModel
    
    @State private var name = ""
    @State private var category = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre del habito", text: $name)
                TextField("Categoria", text: $category)
            }
            
            .navigationTitle("Nuevo Habito")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        viewModel.addHabit(name: name, category: category)
                        dismiss()
                    }
                    .disabled(name.isEmpty || category.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddHabitView(viewModel: HabitViewModel())
}

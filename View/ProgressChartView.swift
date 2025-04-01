//
//  ProgressChartView.swift
//  MindFit
//
//  Created by Alexis Jose Palma Ortiz on 16/03/25.
//

import SwiftUI
import Charts

struct ProgressChartView: View {
    let completedHabits: Int
    let totalHabits: Int
    
    var body: some View {
        VStack {
            Text("Progreso de Hábitos")
                .font(.title2)
                .bold()
                .padding()
            
            Chart {
                BarMark(
                    x: .value("Estado", "Completados"),
                    y: .value("Cantidad", completedHabits)
                )
                .foregroundStyle(.green) // ✅ Usar foregroundStyle en lugar de foregroundColor
                
                
                BarMark(
                    x: .value("Estado", "Pendientes"),
                    y: .value("Cantidad", totalHabits - completedHabits)
                )
                .foregroundStyle(.red) // ✅ Corregir el color
                
            }
            .frame(height: 200)
            .padding()
        }
    }
}

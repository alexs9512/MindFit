import SwiftUI
import UserNotifications

struct MedicationView: View {
    @State private var medicationName: String = ""
    @State private var doses: String = ""
    @State private var time: Date = Date()
    @State private var medications: [Medication] = []
    
    init() {
        requestNotificationPermissions()
    }
    
    var body: some View {
        Form {
            Section(header: Text("Información del Medicamento")) {
                TextField("Nombre del medicamento", text: $medicationName)
                TextField("Dosis", text: $doses)
                    .keyboardType(.decimalPad)
                
                // Modificar el selector de hora
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hora de tomar tu medicamento")
                        .foregroundColor(.gray)
                    
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                }
            }
            
            Button(action: {
                saveMedicationData()
                scheduleLocalNotification(medicationName: medicationName, doses: doses, time: time)
                medications = loadMedicationsData()
            }) {
                Text("Guardar Medicamento")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Section(header: Text("Medicamentos guardados")) {
                List {
                    ForEach(medications) { medication in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(medication.name)
                                    .font(.headline)
                                Text("Dosis: \(medication.dose)")
                                    .font(.subheadline)
                                Text("Hora: \(medication.time.formatted(date: .omitted, time: .shortened))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteMedication) // Permite eliminar un medicamento
                }
                
                Button(action: {
                    deleteAllMedications() // Eliminar todos los medicamentos
                }) {
                    Text("Eliminar Todos")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle("Agregar Medicamento")
        .onAppear {
            medications = loadMedicationsData()
        }
    }
    
    // Función para guardar los medicamentos
    func saveMedicationData() {
        let medication = Medication(name: medicationName, dose: doses, time: time)
        var savedMedications: [Medication] = loadMedicationsData()
        savedMedications.append(medication)
        
        if let encodedData = try? JSONEncoder().encode(savedMedications) {
            UserDefaults.standard.set(encodedData, forKey: "medicationData")
        }
    }
    
    // Función para cargar los medicamentos guardados
    func loadMedicationsData() -> [Medication] {
        if let savedData = UserDefaults.standard.data(forKey: "medicationData"),
            let decodedData = try? JSONDecoder().decode([Medication].self, from: savedData) {
                return decodedData
        }
        return []
    }
    
    // Función para eliminar un medicamento
    func deleteMedication(at offsets: IndexSet) {
        medications.remove(atOffsets: offsets)
        saveAllMedications()
    }
    
    // Función para eliminar todos los medicamentos
    func deleteAllMedications() {
        medications.removeAll()
        saveAllMedications()
    }
    
    // Función para guardar los medicamentos luego de eliminarlos
    func saveAllMedications() {
        if let encodedData = try? JSONEncoder().encode(medications) {
            UserDefaults.standard.set(encodedData, forKey: "medicationData")
        }
    }
    
    // Función para programar la notificación
    func scheduleLocalNotification(medicationName: String, doses: String, time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Es hora de tomar tu medicamento"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let formattedTime = formatter.string(from: time)
        content.body = "Recuerda tomar \(medicationName) con tu dosis (\(doses)) a las \(formattedTime)."
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error al añadir la notificación: \(error.localizedDescription)")
            } else {
                print("Notificación programada con éxito")
            }
        }
    }
    
    // Función para solicitar permisos de notificaciones
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Permiso concedido")
            } else {
                print("Permiso denegado")
            }
        }
    }
}

#Preview {
    MedicationView()
}


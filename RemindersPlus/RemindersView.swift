//
//  RemindersView.swift
//  RemindersPlus
//
//  Created by Samira Resouliikhechi on 24/11/23.
//

import SwiftUI

struct RemindersView: View {
    @State private var reminders: [Reminder] = []
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        NavigationView {
            List {
                ForEach(reminders, id: \.id) { reminder in
                    VStack(alignment: .leading) {
                        Text("Title: \(reminder.title)")
                            .font(.title.bold())
                        Text("Note:\(reminder.notes)")
                        Text("Date: \(reminder.date ?? Date(), formatter: dateFormatter)")
                        Text("Time: \(reminder.time ?? Date(), formatter: timeFormatter)")
                        Text("Tags: \(reminder.tags.joined(separator: ", "))")
                        Text("Location: \(reminder.location)")
                        Text("Flagged: \(reminder.isFlagged ? "Yes" : "No")")
                        Text("Priority: \(reminder.priorityStatus)")
                    }
                }
                .onDelete(perform: deleteReminder)
            }
            .navigationBarTitle("Reminders",displayMode: .inline)
            .onAppear(perform: loadReminders)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    func loadReminders() {
        let keys = UserDefaults.standard.dictionaryRepresentation().keys
        let decoder = JSONDecoder()
        reminders = keys.compactMap { key in
            if key.hasPrefix("Reminder_"),
               let data = UserDefaults.standard.data(forKey: key),
               let reminder = try? decoder.decode(Reminder.self, from: data) {
                return reminder
            } else {
                return nil
            }
        }
    }

    func deleteReminder(at offsets: IndexSet) {
        offsets.forEach { index in
            let reminder = reminders[index]
            let key = "Reminder_\(reminder.id)"
            UserDefaults.standard.removeObject(forKey: key)
        }
        reminders.remove(atOffsets: offsets)
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}



//
//  ModalViewData.swift
//  JournalX
//
//  Created by Samira Resouliikhechi on 17/11/23.
//

import SwiftUI

class ModalViewData: ObservableObject {
    @Published var reminders: [Reminder] = []

    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
}

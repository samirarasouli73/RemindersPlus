//
//  AddListData.swift
//  JournalX
//
//  Created by Samira Resouliikhechi on 17/11/23.
//

import SwiftUI

class AddListData: ObservableObject {
    @Published var listName = ""
    @Published var selectedColor = Color.blue
    @Published var selectedIcon = "list.bullet"
    @Published var selectedSegment = 0
    @Published var colors: [Color] = [.red, .blue, .green, .yellow, .orange, .pink, .purple, .gray, .black, .teal, .brown, .cyan]
    @Published var icons: [String] = [
        "bell", "bell.fill", "calendar", "calendar.circle", "clock", "clock.fill",
        "alarm", "alarm.fill", "stopwatch", "stopwatch.fill", "timer", "hourglass",
        "hourglass.bottomhalf.fill", "hourglass.tophalf.fill", "checkmark.circle",
        "checkmark.circle.fill", "exclamationmark.circle", "exclamationmark.circle.fill",
        "xmark.circle", "xmark.circle.fill", "pencil", "pencil.circle", "trash",
        "trash.fill", "folder", "folder.fill", "paperplane", "paperplane.fill",
        "list.bullet", "list.dash", "list.number", "list.star", "list.triangle",
        "flag", "flag.fill", "flag.circle", "flag.circle.fill", "bookmark", "bookmark.fill",
        "book", "book.fill", "book.circle", "book.circle.fill", "note", "note.text",
        "note.text.badge.plus", "globe", "globe.asia.australia.fill", "map", "map.fill",
        "mappin", "mappin.circle", "mappin.circle.fill", "mappin.slash", "location",
        "location.fill", "location.circle", "location.circle.fill", "location.north",
        "location.north.fill", "location.north.line", "location.north.line.fill",
        "location.slash", "location.slash.fill", "envelope.circle",
        "envelope.circle.fill"
    ]

}

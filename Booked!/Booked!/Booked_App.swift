//
//  Booked_App.swift
//  Booked!
//
//  Created by gwen bradshaw on 1/29/26.
//

import SwiftUI
import SwiftData

@main
struct Booked_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: CalendarEvent.self)
        }
    }
}

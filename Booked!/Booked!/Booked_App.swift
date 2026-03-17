import SwiftUI
import SwiftData

@main
struct Booked_App: App {

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [CalendarEvent.self]) // Add other models here
                .onAppear{
                    NotificationManager.instance.requestPermission()
                }
        }
    }
}

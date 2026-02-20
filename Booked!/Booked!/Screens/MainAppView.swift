// screen for student, worker, human for the tabs there

import SwiftUI
struct MainAppView: View {
    let role: String
    let mode: AppMode
    @State private var showingCalendar = false
    @State private var showingAddEvent = false
    @AppStorage("userRole") var userRole: String = "None"
    @Binding var activeMode: AppMode?
    
    // /(role) is how you make a variable
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        NavigationStack{
            VStack{
                Text(mode.rawValue.uppercased())
                    .font(.system(size:40, weight: .black))
                    .foregroundColor(mode.themeColor)
                    .padding(.top)
                
                Divider()
                
                //grid layout
                LazyVGrid(columns: columns, spacing:30){
                    DashboardItem(icon: "doc.text", label: mode == .personal ? "Notes" : "Assignments", color: mode.themeColor)
                    DashboardItem(icon: "checklist", label: "To-Do's", color: mode.themeColor)
                   //button to see calendar
                    Button(action: { showingCalendar = true }) {
                        DashboardItem(icon: "calendar", label: "Calendar", color: mode.themeColor)
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: { activeMode = nil }) {
                    Label("Switch Side", systemImage: "arrow.left.arrow.rigt")
                }
                .padding()
                .buttonStyle(.bordered)

                
            }
            .sheet(isPresented: $showingCalendar){
                CalendarView(mode: mode)
            }
        }
    }
}

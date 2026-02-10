
import SwiftUI

struct ContentView: View {
    //saving selection to phone memory
    @AppStorage("userRole") var userRole: String = "None"

    var body: some View {
        if userRole == "None" {
            OnboardingView(selectedRole: $userRole)
        } else{
            //show main app once selection has been made
            MainAppView(role: userRole)
        }

    }

}
//the pop up options/screen
struct OnboardingView: View {
    @Binding var selectedRole: String
    var body: some View{
        VStack(spacing: 20){
            Text("Welcome to Booked!")
            .font(.largeTitle)
            .bold()

            Button("I'm a Student 🎓"){ selectedRole = "Student"}
            .buttonStyle(.borderedProminent)

            Button ("I'm working 💼"){ selectedRole = "Worker"}
            .buttonStyle(.borderedProminent)

            Button("Neither😛") {selectedRole = "Human"}
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
struct MainAppView: View {
    let role: String
    @AppStorage("userRole") var userRole: String = "None"
    // /(role) is how you make a variable
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View{
        VStack{
            Text(role.uppercased())
                .font(.system(size:40, weight: .black))
                .padding(.top)

                Divider()

                //grid layout
                LazyVGrid(columns: columns, spacing:30){
                    DashboardItem(icon: "calendar", label: "Calendar")
                    DashboardItem(icon: "doc.text", label: "Assignments")
                    DashboardItem(icon: "checklist", label: "To-Do's")
                }
                .padding()

                Spacer()

                //back to options button
                Divider()
                HStack{
                    Button(action: { userRole = "None" }) {
                        VStack {
                            Image(systemName: "arrow.left.square")
                            Text("Back to Options").font(.caption)
                        }
                    }
                    .padding()
                    .foregroundColor(.red)

                    Spacer()
                    }
                }
            }
        }
        // helper view
        struct DashboardItem: View {
            let icon: String
            let label: String

            var body: some View{
                VStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary, lineWidth: 2)
                        .frame(width: 80, height: 80)
                        .overlay(Image(systemName: icon).font(.largeTitle))
                    
                    Text(label)
                        .font(.caption)
                        .bold()


                }
            }
        }
    

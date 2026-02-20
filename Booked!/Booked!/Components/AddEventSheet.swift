//
//  AddEventSheet.swift
//  Booked!
//
//  Created by gwen bradshaw on 2/12/26.
//

import SwiftUI
import SwiftData

struct AddEventSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var eventTitle: String = ""
    @State private var selectedDate = Date()
    @State private var selectedState: AppMode = .work
    @State private var selectedType = "Meeting"
    
    @State private var selectedRepeatDays: Set<Int> = []
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View{
        NavigationStack{
            Form{
                Section("Event Details"){
                    TextField("Title", text: $eventTitle)
                    DatePicker("Date", selection: $selectedDate)
                }
                Section("Repeat on"){
                    HStack (spacing: 0){
                        ForEach(1...7, id:\.self) { day in
                            Text(String(daysOfWeek[day - 1].prefix(1)))
                                .font(.caption)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .frame(height:35)
                                .background(selectedRepeatDays.contains(day) ?selectedState.themeColor : Color.secondary.opacity(0.2))
                                .foregroundColor(selectedRepeatDays.contains(day) ? .white: .primary)
                                .clipShape(Circle())
                                .onTapGesture {
                                    if selectedRepeatDays.contains(day){
                                        selectedRepeatDays.remove(day)
                                    } else{
                                        selectedRepeatDays.insert(day)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
                Section("Category"){
                    //first pick choose your state
                    Picker("State", selection: $selectedState){
                        ForEach(AppMode.allCases, id: \.self) { state in
                            Text (state.rawValue).tag(state)
                        }
                    }
                    .onChange(of: selectedState){
                        selectedType = selectedState.options.first ?? "Task"
                    }
                    Picker("Type", selection: $selectedType){
                        ForEach(selectedState.options, id: \.self){ option in
                            Text(option).tag(option)
                        }
                    }
                }
            }
            .navigationTitle(Text("Add Event"))
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        let newEvent = CalendarEvent (
                            title: eventTitle,
                            timestamp: selectedDate,
                            eventType: selectedType,
                            stateGroup: selectedState.rawValue,
                            repeatDays: Array(selectedRepeatDays)
                            )
                        modelContext.insert(newEvent)
                        dismiss()
                    }
                    .disabled(eventTitle.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel") { dismiss()}
                }
            }
        }
    }
}

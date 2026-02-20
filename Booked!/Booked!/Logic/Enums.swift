//
//  Enums.swift
//  Booked!
//
//  Created by gwen bradshaw on 2/5/26.
//
import Foundation
import SwiftUI

enum AppMode: String, CaseIterable {
    case personal = "Personal"
    case school = "School"
    case work = "Work"
    
    var themeColor: Color {
        switch self{
        case .personal: return .green
        case .school: return .blue
        case .work: return .red
        }
    }
    var options: [String] {
    switch self {
    case .work:
        return ["Meeting", "Task", "Email Follow-up"]
    case .school:
        return ["Class", "Assignment", "Meeting", "Email", "Exam"]
    case .personal:
        return ["Gym", "Groceries", "Friends", "To-do" ]
    }
}
}


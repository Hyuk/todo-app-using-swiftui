//
//  TodoItem.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/22/25.
//

import Foundation
import SwiftData

@Model
final class TodoItem {
    var id: String = UUID().uuidString
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var priority: Priority = Priority.medium
    
    init(title: String, isCompleted: Bool = false, priority: Priority = Priority.medium, createdAt: Date = Date()) {
        self.title = title
        self.isCompleted = isCompleted
        self.priority = priority
        self.createdAt = createdAt
    }
}

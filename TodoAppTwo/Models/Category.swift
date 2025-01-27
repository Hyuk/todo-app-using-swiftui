//
//  Category.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/28/25.
//

import Foundation
import SwiftData

@Model
final class Category {
    var id: String = UUID().uuidString
    var name: String?
    
    @Relationship(deleteRule: .cascade)
    var todos: [TodoItem]? = []
    
    init(name: String) {
        self.name = name
    }
}

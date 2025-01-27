//
//  Priority.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/27/25.
//

import Foundation

enum Priority: Int, Codable {
    case low = 0
    case medium = 1
    case high = 2
    
    var title: String {
        switch self {
        case .low:
            return "낮음"
        case .medium:
            return "중간"
        case .high:
            return "높음"
        }
    }
}

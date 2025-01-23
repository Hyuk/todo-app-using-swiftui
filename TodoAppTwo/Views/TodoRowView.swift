//
//  TodoRowView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI

struct TodoRowView: View {
    let item: TodoItem
    
    var body: some View {
        NavigationLink {
            TodoDetailView(item: item)
        } label: {
            Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
        }
    }
}

#Preview {
    TodoRowView(item: TodoItem(title: "Hello World"))
}

//
//  TodoListView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var todos: [TodoItem]
    
    var body: some View {
        List {
            ForEach(todos) { item in
                NavigationLink {
                    TodoDetailView(item: item)
                } label: {
                    Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                }
            }
            .onDelete(perform: deleteItems)
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(todos[index])
            }
        }
    }
}

#Preview {
    TodoListView()
}

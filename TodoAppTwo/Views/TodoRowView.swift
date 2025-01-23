//
//  TodoRowView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI

struct TodoRowView: View {
    let item: TodoItem
    
    @State private var showingEditView: Bool = false
    
    var body: some View {
        HStack {
            Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .onLongPressGesture {
                    showingEditView = true
                }
            NavigationLink(value: TodoNavigation.detail(item)) {
                Text(" ")
            }
        }
        .swipeActions(edge: .leading) {
            NavigationLink(value: TodoNavigation.edit(item)) {
                Text("Edit")
            }
            .tint(.yellow)
        }
        .sheet(isPresented: $showingEditView) {
            NavigationStack {
                EditTodoView(todo: item)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            TodoRowView(item: TodoItem(title: "Hello World"))
        }
        .navigationTitle("Todo List")
    }
    
    
}

//
//  TodoRowView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI

struct TodoRowView: View {
    let todo: TodoItem
    
    @State private var showingEditView: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                todo.isCompleted.toggle()
            }, label: {
                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
            })
            Text("\(todo.title) at \(todo.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .onLongPressGesture {
                    showingEditView = true
                }
            NavigationLink(value: TodoNavigation.detail(todo)) {
                Text(" ")
            }
        }
        .swipeActions(edge: .leading) {
            NavigationLink(value: TodoNavigation.edit(todo)) {
                Text("Edit")
            }
            .tint(.yellow)
        }
        .sheet(isPresented: $showingEditView) {
            NavigationStack {
                EditTodoView(todo: todo)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            TodoRowView(todo: TodoItem(title: "Hello World"))
        }
        .navigationTitle("Todo List")
    }
    
    
}

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
            VStack(alignment: .leading) {
                Text(todo.title)
                Text(todo.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .onLongPressGesture(minimumDuration: 0.5) {
                showingEditView = true
            }
        }
        .swipeActions(edge: .leading) {
            NavigationLink(value: TodoNavigation.detail(todo)) {
                Text("Detail")
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

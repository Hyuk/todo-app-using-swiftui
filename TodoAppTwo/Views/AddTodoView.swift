//
//  AddTodoView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var priority: Priority = .medium
    @State private var dueDateEnabled = false
    @State private var dueDate: Date? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("제목", text: $title)
                    Picker("우선순위", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) {
                            priority in
                            Text(priority.title)
                                .tag(priority)
                        }
                    }
                    Toggle("마감일 설정", isOn: $dueDateEnabled)
                    if dueDateEnabled {
                        DatePicker("마감일",
                                   selection: Binding(get: {
                            dueDate ?? Date()
                        }, set:{
                            dueDate = $0
                        }))
                    }
                }
            }
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let todo = TodoItem(title: title,
                                            priority: priority,
                                            dueDate: dueDateEnabled ? dueDate : nil)
                        modelContext.insert(todo)
                        dismiss()
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    AddTodoView()
}

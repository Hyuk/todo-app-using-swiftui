//
//  EditTodoView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI
import SwiftData

struct EditTodoView: View {
    @Environment(\.dismiss) var dismiss
    
    @Query private var categories: [Category]
    
    let todo: TodoItem
    
    @State var title: String = ""
    @State var priority: Priority
    @State private var dueDateEnabled = false
    @State private var dueDate: Date? = nil
    @State private var selectedCategory: Category?
    
    init(todo: TodoItem) {
        self.todo = todo
        self._title = State(initialValue: todo.title)
        self._priority = State(initialValue: todo.priority)
        self._dueDateEnabled = State(initialValue: todo.dueDate != nil)
        self._dueDate = State(initialValue: todo.dueDate)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
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
            Section("Category") {
                Picker("카테고리", selection: $selectedCategory) {
                    Text("선택안함").tag(Optional<Category>.none)
                    ForEach(categories) { category in
                        Text(category.name ?? "-").tag(Optional(category))
                    }
                }
            }
        }
        .navigationTitle("Edit Todo")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Save") {
                    // 수정 기능
                    todo.title = title
                    todo.priority = priority
                    todo.dueDate = dueDateEnabled ? dueDate : nil
                    // 뷰 닫기와 동시에 모델 컨텍스트 저장이 호출된다.
                    dismiss()
                    
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        
    }
}

#Preview {
    EditTodoView(todo: TodoItem(title: "Hello, world!"))
        .modelContainer(PreviewContainer.shared.container)
}

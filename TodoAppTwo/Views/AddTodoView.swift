//
//  AddTodoView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI
import SwiftData

struct AddTodoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var categories: [Category]
    
    @State private var title: String = ""
    @State private var priority: Priority = .medium
    @State private var dueDateEnabled = false
    @State private var dueDate: Date? = nil
    @State private var selectedCategory: Category?
    
    @State private var isAddingCategory = false
    @State private var newCategoryName = ""
    
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
                Section("Category") {
                    Picker("카테고리", selection: $selectedCategory) {
                        Text("선택안함").tag(Optional<Category>.none)
                        ForEach(categories) { category in
                            Text(category.name ?? "-").tag(Optional(category))
                        }
                    }
                    Button("카테고리 추가") {
                        isAddingCategory = true
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
            .alert("카테고리 추가",
                   isPresented: $isAddingCategory
            ) {
                TextField("카테고리 이름", text: $newCategoryName)
                HStack {
                    Button("취소") {
                        newCategoryName = ""
                    }
                    Button("추가") {
                        if !newCategoryName.isEmpty {
                            let category = Category(name: newCategoryName)
                            modelContext.insert(category)
                        }
                    }
                }
            } message: {
                Text("카테고리 이름을 입력하세요.")
            }
        }
        
        
    }
}

#Preview {
    AddTodoView()
    .modelContainer(PreviewContainer.shared.container)
}

//
//  TodoListView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI
import SwiftData

enum TodoNavigation: Hashable {
    case detail(TodoItem)
    case edit(TodoItem)
}

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var categories: [Category]
    @Query private var todos: [TodoItem]
    
    let searchText: String
    let priorityFilter: Priority?
    
    init(searchText: String = "", priorityFilter: Priority? = nil) {
        self.searchText = searchText
        self.priorityFilter = priorityFilter
        
        let predicate = #Predicate<TodoItem> { todo in
            searchText.isEmpty ? true :
            todo.title.contains(searchText)
        }
        
        _todos = Query(filter: predicate, sort: [SortDescriptor(\TodoItem.createdAt)])
    }
    
    func filteredTodos(category: Category? = nil) -> [TodoItem] {
            let categoryTodos = todos.filter { $0.category == category }
            if let priority = priorityFilter {
                return categoryTodos.filter { $0.priority == priority }
            }
            return categoryTodos
        }
    
    var body: some View {
        List {
            Section("카테고리 없음") {
                ForEach(filteredTodos(category: nil)) { item in
                    TodoRowView(todo: item, showCategory: false)
                }
                .onDelete(perform: deleteItems)
            }
            ForEach(categories) { category in
                Section(category.name ?? "-") {
                    ForEach(filteredTodos(category: category)) { item in
                        TodoRowView(todo: item, showCategory: false)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
        .navigationDestination(for: TodoNavigation.self) { navigation in
            switch navigation {
                case .detail(let item):
                    TodoDetailView(item: item)
                case .edit(let item):
                    EditTodoView(todo: item)
            }
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
        .modelContainer(PreviewContainer.shared.container)
}

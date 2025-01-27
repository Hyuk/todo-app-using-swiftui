//
//  CalendarView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/28/25.
//

import SwiftUI
import SwiftData
struct CalendarView: View {
    @Query private var todos: [TodoItem]
    
    @State private var selectedDate: Date = Date()
    
    private var todosForSelectedDate: [TodoItem] {
        todos.filter { todo in
            todo.dueDate != nil ? Calendar.current.isDate(todo.dueDate!, inSameDayAs: selectedDate) : false
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()
                
                List {
                    ForEach(todosForSelectedDate) { todo in
                        TodoRowView(todo: todo)
                    }
                }
            }
            .navigationTitle("Calendar")
        }
    }
}
#Preview {
    CalendarView()
        .modelContainer(PreviewContainer.shared.container)
}

//
//  TodoDetailView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import SwiftUI

struct TodoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingEditView: Bool = false
    
    var item: TodoItem
    
    var body: some View {
        NavigationStack {
            Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Delete") {
                            modelContext.delete(item)
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit") {
                            showingEditView = true
                        }
                    }
                }
        }
        .navigationTitle(item.title)
        .sheet(isPresented: $showingEditView) {
            EditTodoView()
        }
        
    }
}

#Preview {
    TodoDetailView(item: TodoItem(title: "Hello World"))
}

//
//  ContentView.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/22/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var showingAddTodo: Bool = false
    @State private var searchText = ""
    @State private var priorityFilter: Priority? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        priorityFilter = nil
                    } label: {
                        Text("전체")
                            .font(.caption)
                            .padding(4)
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(.rect(cornerRadius: 4))
                    }
                    ForEach([Priority.low, Priority.medium, Priority.high], id: \.self) { priority in
                        Button {
                            priorityFilter = priority
                        } label: {
                            PriorityBadge(priority: priority)
                        }
                    }
                }
                TodoListView(searchText: searchText, priorityFilter: priorityFilter)
                    .searchable(text: $searchText)
                    .navigationTitle("Todo List")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: {
                                showingAddTodo = true
                            }) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
            }
            
        }
        .sheet(isPresented: $showingAddTodo) {
            AddTodoView()
        }
    }

    
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.container)
}





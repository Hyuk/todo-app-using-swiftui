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
        TabView {
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
                                .overlay {
                                    if priorityFilter == nil {
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(.blue, lineWidth: 2)
                                    }
                                }
                        }
                        ForEach([Priority.low, Priority.medium, Priority.high], id: \.self) { priority in
                            Button {
                                priorityFilter = priority
                            } label: {
                                PriorityBadge(priority: priority)
                            }
                            .overlay {
                                if priorityFilter == priority {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.blue, lineWidth: 2)
                                }
                            }
                        }
                    }
                    TodoListView(searchText: searchText, priorityFilter: priorityFilter)
                        .searchable(text: $searchText)
                        .navigationTitle("Todo List")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink {
                                    CategoryListView()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                }
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
            .tabItem {
                Label("List", systemImage: "list.bullet")
            }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
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





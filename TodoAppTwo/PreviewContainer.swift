//
//  PreviewContainer.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/23/25.
//

import Foundation
import SwiftData

// 데이터를 가져다가 화면을 갱신하는 코드이므로 @MainActor 키워드를 넣어준다.
@MainActor
class PreviewContainer {
    // 싱글톤 패턴
    static let shared: PreviewContainer = PreviewContainer()
    
    let container: ModelContainer
    
    init() {
        let schema = Schema([
            TodoItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: true,
                                                    cloudKitDatabase: .none)
        
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertPreviewData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertPreviewData() {
        let today = Date()
        let calendar = Calendar.current
        
        // 예제 데이터 생성
        let todos: [(String, Date, Priority)] = [
            ("Buy groceries", today, .low),
            ("Walk the dog", calendar.date(byAdding: .day, value: 1, to: today)!, .medium),
            ("Do the laundry", calendar.date(byAdding: .day, value: 2, to: today)!, .medium),
            ("Take out the trash", calendar.date(byAdding: .day, value: 3, to: today)!, .low),
            ("완료된 작업", calendar.date(byAdding: .day, value: 4, to: today)!, .low),
            ("운동하기", calendar.date(byAdding: .day, value: 5, to: today)!, .high),
            ("책 읽기", calendar.date(byAdding: .day, value: 6, to: today)!, .high),
            ("SwiftUI 공부", calendar.date(byAdding: .day, value: 7, to: today)!, .high),
        ]
        
        for (title, date, priority) in todos {
            let todo = TodoItem(title: title, priority: priority, createdAt: date)
            container.mainContext.insert(todo)
        }
        
        // 첫번째 투두를 완료 상태로 변경
        if let firstTodo = try? container.mainContext.fetch(FetchDescriptor<TodoItem>()).first {
            firstTodo.isCompleted = true
        }
        
        // 변경사항을 저장
        try? container.mainContext.save()
    }
}

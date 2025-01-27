//
//  TodoAppTwoApp.swift
//  TodoAppTwo
//
//  Created by Hyuk Ho Song on 1/22/25.
//

import SwiftUI
import SwiftData

@main
struct TodoAppTwoApp: App {
    var sharedModelContainer: ModelContainer = {
            let schema = Schema(versionedSchema: SchemaV2.self)
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                let container = try ModelContainer(
                    for: schema,
                    migrationPlan: MigrationPlan.self,
                    configurations: [modelConfiguration]
                )
                // 마이그레이션 성공
                print("Successfully created ModelContainer with migration")
                return container
            } catch {
                // 더 자세한 에러 처리
                print("Failed to create ModelContainer: \(error)")
                print("Error details: \(error.localizedDescription)")
                
                // 최후의 수단으로 데이터를 초기화하고 새로 시작
                do {
                    let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
                    let container = try ModelContainer(for: schema, configurations: [configuration])
                    print("Created fresh ModelContainer after error")
                    return container
                } catch {
                    fatalError("Could not create ModelContainer: \(error)")
                }
            }
        }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

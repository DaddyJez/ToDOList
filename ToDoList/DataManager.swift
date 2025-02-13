//
//  DataManager.swift
//  ToDoList
//
//  Created by Влад Карагодин on 11.02.2025.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private init() {}

    func generateRandomDescription() -> String {
        let descriptions = [
            "This is an important task that needs to be done.",
            "Don't forget to complete this task on time.",
            "A simple task that can be done quickly.",
            "This task requires some preparation.",
            "Make sure to prioritize this task."
        ]
        return descriptions.randomElement() ?? "No description"
    }

    func generateRandomDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        let randomDays = Int.random(in: 0...30)
        if let randomDate = Calendar.current.date(byAdding: .day, value: randomDays, to: Date()) {
            return dateFormatter.string(from: randomDate)
        }
        return dateFormatter.string(from: Date())
    }

    func convertToTask(todos: [Todo]) -> [Task] {
        return todos.map { todo in
            Task(
                id: todo.id,
                title: todo.todo,
                description: generateRandomDescription(),
                completed: todo.completed,
                userId: todo.userId,
                date: generateRandomDate()
            )
        }
    }
}

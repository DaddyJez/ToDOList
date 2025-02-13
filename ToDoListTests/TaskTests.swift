//
//  TaskTests.swift
//  ToDoListTests
//
//  Created by Влад Карагодин on 13.02.2025.
//

import XCTest
@testable import ToDoList

class TaskTests: XCTestCase {

    func testTaskInitialization() {
        let task = Task(id: 1, title: "Test Task", description: "Test Description", completed: false, userId: 1, date: "12/02/25")
        XCTAssertEqual(task.id, 1, "Task ID should match")
        XCTAssertEqual(task.title, "Test Task", "Task title should match")
        XCTAssertEqual(task.description, "Test Description", "Task description should match")
        XCTAssertEqual(task.completed, false, "Task completed status should match")
        XCTAssertEqual(task.userId, 1, "Task user ID should match")
        XCTAssertEqual(task.date, "12/02/25", "Task date should match")
    }
}

//
//  DataManagerTests.swift
//  ToDoListTests
//
//  Created by Влад Карагодин on 13.02.2025.
//

import XCTest
@testable import ToDoList

class DataManagerTests: XCTestCase {

    var dataManager: DataManager!

    override func setUp() {
        super.setUp()
        dataManager = DataManager.shared
    }

    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }

    func testGenerateRandomDescription() {
        let description = dataManager.generateRandomDescription()
        XCTAssertFalse(description.isEmpty, "Description should not be empty")
    }

    func testGenerateRandomDate() {
        let date = dataManager.generateRandomDate()
        XCTAssertFalse(date.isEmpty, "Date should not be empty")
    }

    func testConvertToTask() {
        let todos = [
            Todo(id: 1, todo: "Test Todo", completed: false, userId: 1)
        ]
        let tasks = dataManager.convertToTask(todos: todos)
        XCTAssertEqual(tasks.count, 1, "Should convert todos to tasks")
        XCTAssertEqual(tasks.first?.title, "Test Todo", "Task title should match")
    }
}

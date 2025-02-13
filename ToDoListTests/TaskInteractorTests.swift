//
//  TaskInteractorTests.swift
//  ToDoListTests
//
//  Created by Влад Карагодин on 13.02.2025.
//

import XCTest
@testable import ToDoList

class TaskInteractorTests: XCTestCase {

    var taskInteractor: TaskInteractor!
    var mockOutput: MockTaskInteractorOutput!

    override func setUp() {
        super.setUp()
        taskInteractor = TaskInteractor()
        mockOutput = MockTaskInteractorOutput()
        taskInteractor.output = mockOutput
    }

    override func tearDown() {
        taskInteractor = nil
        mockOutput = nil
        super.tearDown()
    }

    func testToggleComplete() {
        let task = Task(id: 1, title: "Test Task", description: "Test Description", completed: false, userId: 1, date: "12/02/25")
        taskInteractor.toggleComplete(for: task)
        XCTAssertTrue(mockOutput.didToggleCompleteCalled, "Output should be called")
    }
}

class MockTaskInteractorOutput: TaskInteractorOutput {
    var didToggleCompleteCalled = false

    func didToggleComplete(for task: Task) {
        didToggleCompleteCalled = true
    }
}

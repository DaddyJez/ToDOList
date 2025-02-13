//
//  CoreDataManagerTests.swift
//  ToDoListTests
//
//  Created by Влад Карагодин on 13.02.2025.
//

import XCTest
import CoreData
@testable import ToDoList

class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager.shared

        // Очищаем CoreData перед каждым тестом
        let tasks = coreDataManager.fetchTasksFromCoreData()
        for task in tasks {
            coreDataManager.deleteTask(task)
        }
    }

    override func tearDown() {
        coreDataManager = nil
        super.tearDown()
    }

    func testSaveAndFetchTasks() {
        let task = Task(id: 1, title: "Test Task", description: "Test Description", completed: false, userId: 1, date: "12/02/25")
        coreDataManager.saveTask(task)

        let fetchedTasks = coreDataManager.fetchTasksFromCoreData()
        XCTAssertFalse(fetchedTasks.isEmpty, "Tasks should not be empty after saving")
        XCTAssertEqual(fetchedTasks.first?.title, "Test Task", "Saved task title should match")
    }

    func testUpdateTask() {
        let task = Task(id: 1, title: "Test Task", description: "Test Description", completed: false, userId: 1, date: "12/02/25")
        coreDataManager.saveTask(task)

        var updatedTask = task
        updatedTask.title = "Updated Task"
        coreDataManager.updateTask(updatedTask)

        let fetchedTasks = coreDataManager.fetchTasksFromCoreData()
        XCTAssertEqual(fetchedTasks.first?.title, "Updated Task", "Task title should be updated")
    }

    func testDeleteTask() {
        let task = Task(id: 1, title: "Test Task", description: "Test Description", completed: false, userId: 1, date: "12/02/25")
        coreDataManager.saveTask(task)

        coreDataManager.deleteTask(task)
        let fetchedTasks = coreDataManager.fetchTasksFromCoreData()
        XCTAssertTrue(fetchedTasks.isEmpty, "Tasks should be empty after deletion")
    }
}

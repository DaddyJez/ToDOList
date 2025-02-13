//
//  EditTaskViewControllerTests.swift
//  ToDoListTests
//
//  Created by Влад Карагодин on 13.02.2025.
//

import XCTest
@testable import ToDoList

class EditTaskViewControllerTests: XCTestCase {

    var editTaskViewController: EditTaskViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        editTaskViewController = storyboard.instantiateViewController(withIdentifier: "EditTaskViewController") as? EditTaskViewController
        editTaskViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        editTaskViewController = nil
        super.tearDown()
    }

    func testSetupUI() {
        let task = Task(id: 1, title: "Test Task", description: "Test Description", completed: false, userId: 1, date: "12/02/25")
        editTaskViewController.task = task
        editTaskViewController.viewDidLoad() // Вызываем viewDidLoad, который вызывает setupUI

        XCTAssertEqual(editTaskViewController.taskTextView.text, "Test Task", "Task title should be set")
        XCTAssertEqual(editTaskViewController.taskTextDescription.text, "Test Description", "Task description should be set")
        XCTAssertEqual(editTaskViewController.taskDateView.text, "12/02/25", "Task date should be set")
    }

    func testSaveTask() {
        let task = Task(id: 1, title: "Test Task", description: "Test Description", completed: false, userId: 1, date: "12/02/25")
        editTaskViewController.task = task
        editTaskViewController.taskTextView.text = "Updated Task"
        editTaskViewController.taskTextDescription.text = "Updated Description"

        var savedTask: Task?
        editTaskViewController.onSave = { task in
            savedTask = task
        }

        editTaskViewController.viewWillDisappear(false)

        XCTAssertEqual(savedTask?.title, "Updated Task", "Task title should be updated")
        XCTAssertEqual(savedTask?.description, "Updated Description", "Task description should be updated")
    }
}

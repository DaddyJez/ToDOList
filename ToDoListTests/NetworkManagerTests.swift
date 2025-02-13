//
//  NetworkManagerTests.swift
//  ToDoListTests
//
//  Created by Влад Карагодин on 13.02.2025.
//

import XCTest
@testable import ToDoList

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testFetchTodos() {
        let expectation = XCTestExpectation(description: "Fetch todos from network")

        networkManager.fetchTodos { todos in
            XCTAssertNotNil(todos, "Todos should not be nil")
            XCTAssertFalse(todos?.isEmpty ?? true, "Todos should not be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

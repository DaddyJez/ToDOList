//
//  Interactor.swift
//  ToDoList
//
//  Created by Влад Карагодин on 10.02.2025.
//

protocol TaskInteractorInput {
    func toggleComplete(for task: Task)
}

class TaskInteractor: TaskInteractorInput {

    weak var output: TaskInteractorOutput?

    func toggleComplete(for task: Task) {
        output?.didToggleComplete(for: task)
    }
}


//
//  Presenter.swift
//  ToDoList
//
//  Created by Влад Карагодин on 10.02.2025.
//

protocol TaskModuleInput: AnyObject {
    var view: TaskViewInput? { get set }
    func userDidToggleComplete(for task: Task)
}

protocol TaskInteractorOutput: AnyObject {
    func didToggleComplete(for task: Task)
}

class TaskPresenter: TaskModuleInput, TaskInteractorOutput {

    var view: TaskViewInput?
    var interactor: TaskInteractorInput?

    func userDidToggleComplete(for task: Task) {
        interactor?.toggleComplete(for: task)
    }

    func didToggleComplete(for task: Task) {
        view?.updateTask(task)
    }
}

//
//  TaskProtocols.swift
//  ToDoList
//
//  Created by Влад Карагодин on 10.02.2025.
//

import Foundation

protocol TaskViewInput: AnyObject {
    func updateTask(_ task: Task)
}

protocol TaskCellDelegate: AnyObject {
    func didToggleComplete(for cell: TaskTableViewCell)
    func didTapEdit(for cell: TaskTableViewCell)
    func didTapShare(for cell: TaskTableViewCell)
    func didTapDelete(for cell: TaskTableViewCell)
}

//
//  EditTaskViewController.swift
//  ToDoList
//
//  Created by Влад Карагодин on 12.02.2025.
//

import UIKit

class EditTaskViewController: UIViewController {

    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var taskTextDescription: UITextView!
    @IBOutlet weak var taskDateView: UILabel!
    
    var task: Task?
    var onSave: ((Task?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if task?.title == "" {
            taskTextView.becomeFirstResponder()
        }
    }

    private func setupUI() {
        if let task = task {
            taskTextView.text = task.title
            taskTextDescription.text = task.description
            taskDateView.text = task.date
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if var task = task {
            if taskTextView.text.isEmpty {
                CoreDataManager.shared.deleteTask(task)
                onSave?(nil)
                return
            }
            
            task.title = taskTextView.text
            task.description = taskTextDescription.text
            CoreDataManager.shared.updateTask(task) // Сохраняем изменения в CoreData
            onSave?(task)
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

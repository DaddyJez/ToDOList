//
//  ViewController.swift
//  ToDoList
//
//  Created by Влад Карагодин on 10.02.2025.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TaskCellDelegate, TaskViewInput, UISearchBarDelegate {

    var tasks: [Task] = []
    var presenter: TaskModuleInput?

    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskCountLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var filteredTasks: [Task] = []
    var isSearching = false
    let hasLaunchedBeforeKey = "hasLaunchedBefore"

    private func updateTaskCount() {
        let count = isSearching ? filteredTasks.count : tasks.count
        taskCountLabel.text = "\(count) Задач"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Проверка первого запуска
        if !UserDefaultsManager.shared.hasLaunchedBefore {
            // Первый запуск: загружаем данные из JSON
            loadDataFromJSON()
            UserDefaultsManager.shared.hasLaunchedBefore = true
        } else {
            // Последующие запуски: загружаем данные из CoreData
            loadDataFromCoreData()
        }

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadDataFromJSON() {
        NetworkManager.shared.fetchTodos { [weak self] todos in
            guard let todos = todos else { return }

            // Преобразуем Todo в Task и дополняем данные
            let tasks = DataManager.shared.convertToTask(todos: todos)

            DispatchQueue.main.async {
                self?.tasks = tasks
                self?.filteredTasks = tasks
                self?.updateTaskCount()
                self?.tableView.reloadData()

                // Сохраняем задачи в CoreData
                CoreDataManager.shared.saveTasksToCoreData(tasks: tasks)
            }
        }
    }
    
    private func loadDataFromCoreData() {
        tasks = CoreDataManager.shared.fetchTasksFromCoreData()
        filteredTasks = tasks
        updateTaskCount()
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredTasks = tasks
            isSearching = false
        } else {
            filteredTasks = tasks.filter { task in
                task.title.lowercased().contains(searchText.lowercased()) ||
                task.description.lowercased().contains(searchText.lowercased())
            }
            isSearching = true
        }
        updateTaskCount() // Обновляем количество задач
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder() // Скрываем клавиатуру
        filteredTasks = tasks // Показываем все задачи
        isSearching = false
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredTasks.count : tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        cell.dateLabel.text = task.date
        cell.isCompleted = task.completed
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
            didTapEdit(for: cell)
        }
    }

    func didToggleComplete(for cell: TaskTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            var task = tasks[indexPath.row]
            task.completed = !task.completed
            presenter?.userDidToggleComplete(for: task)
        }
    }


    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didTapEdit(for cell: TaskTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let editVC = storyboard.instantiateViewController(withIdentifier: "EditTaskViewController") as? EditTaskViewController {
                editVC.task = task
                
                // Передаем замыкание для сохранения изменений
                editVC.onSave = { [weak self] updatedTask in
                    guard let self = self else { return }
                    
                    if let updatedTask = updatedTask {
                        // Если задача не пустая, обновляем или добавляем ее
                        if let index = self.tasks.firstIndex(where: { $0.id == updatedTask.id }) {
                            self.tasks[index] = updatedTask
                            if self.isSearching {
                                if let filteredIndex = self.filteredTasks.firstIndex(where: { $0.id == updatedTask.id }) {
                                    self.filteredTasks[filteredIndex] = updatedTask
                                }
                            }
                        } else {
                            self.tasks.append(updatedTask)
                            if self.isSearching {
                                self.filteredTasks.append(updatedTask)
                            }
                        }
                    } else {
                        // Если задача пустая, удаляем ее
                        if let task = editVC.task {
                            if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                                self.tasks.remove(at: index)
                                if self.isSearching {
                                    if let filteredIndex = self.filteredTasks.firstIndex(where: { $0.id == task.id }) {
                                        self.filteredTasks.remove(at: filteredIndex)
                                    }
                                }
                            }
                        }
                    }
                    
                    self.updateTaskCount()
                    self.tableView.reloadData()
                }
                
                navigationController?.pushViewController(editVC, animated: true)
            }
        }
    }

    func didTapShare(for cell: TaskTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let task = tasks[indexPath.row]
            // Реализуйте логику для поделиться
            let activityViewController = UIActivityViewController(activityItems: [task.title, task.description], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }

    func didTapDelete(for cell: TaskTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            // Получаем задачу из filteredTasks или tasks в зависимости от режима поиска
            let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
            
            let alert = UIAlertController(title: "Удалить задачу?", message: "Вы уверены, что хотите удалить задачу \"\(task.title)\"?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
                // Удаляем задачу из CoreData
                CoreDataManager.shared.deleteTask(task)
                
                // Удаляем задачу из основного массива tasks
                if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                    self.tasks.remove(at: index)
                }
                
                // Если поиск активен, удаляем задачу из filteredTasks
                if self.isSearching {
                    self.filteredTasks.remove(at: indexPath.row)
                }
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                self.updateTaskCount()
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    private var selectedCell: TaskTableViewCell?

    func didLongPress(on cell: TaskTableViewCell) {
        selectedCell = cell

        addBlurEffect()

        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }

        showActionSheet(for: cell)
    }

    func showActionSheet(for cell: TaskTableViewCell) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let editAction = UIAlertAction(title: "Редактировать", style: .default) { _ in
            self.didTapEdit(for: cell)
            self.removeBlurEffect()
        }

        let shareAction = UIAlertAction(title: "Поделиться", style: .default) { _ in
            self.didTapShare(for: cell)
            self.removeBlurEffect()
        }

        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            self.didTapDelete(for: cell)
            self.removeBlurEffect()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            self.removeBlurEffect()
        }

        alertController.addAction(editAction)
        alertController.addAction(shareAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    private var blurEffectView: UIVisualEffectView?

    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView!)
    }

    func removeBlurEffect() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
    
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        // Создаем новую задачу с сегодняшней датой
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let todayDate = dateFormatter.string(from: Date())
        
        let newTask = Task(
            id: tasks.count + 1,
            title: "",
            description: "",
            completed: false,
            userId: 1,
            date: todayDate
        )
        
        CoreDataManager.shared.saveTask(newTask)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editVC = storyboard.instantiateViewController(withIdentifier: "EditTaskViewController") as? EditTaskViewController {
            editVC.task = newTask
            
            editVC.onSave = { [weak self] updatedTask in
                guard let self = self else { return }
                
                if let updatedTask = updatedTask {
                    if let index = self.tasks.firstIndex(where: { $0.id == updatedTask.id }) {
                        self.tasks[index] = updatedTask
                        if self.isSearching {
                            if let filteredIndex = self.filteredTasks.firstIndex(where: { $0.id == updatedTask.id }) {
                                self.filteredTasks[filteredIndex] = updatedTask
                            }
                        }
                    } else {
                        self.tasks.append(updatedTask)
                        if self.isSearching {
                            self.filteredTasks.append(updatedTask)
                        }
                    }
                } else {
                    if let task = editVC.task {
                        if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                            self.tasks.remove(at: index)
                            if self.isSearching {
                                if let filteredIndex = self.filteredTasks.firstIndex(where: { $0.id == task.id }) {
                                    self.filteredTasks.remove(at: filteredIndex)
                                }
                            }
                        }
                    }
                }
                
                self.updateTaskCount()
                self.tableView.reloadData()
            }
            
            navigationController?.pushViewController(editVC, animated: true)
        }
    }
}

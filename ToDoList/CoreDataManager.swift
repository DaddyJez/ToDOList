//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Влад Карагодин on 11.02.2025.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func updateTask(_ task: Task) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", task.id)

        do {
            if let taskEntity = try context.fetch(fetchRequest).first {
                taskEntity.title = task.title
                taskEntity.taskDescription = task.description
                taskEntity.completed = task.completed
                taskEntity.date = task.date
                saveContext()
            }
        } catch {
            print("Failed to update task: \(error)")
        }
    }

    func deleteTask(_ task: Task) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", task.id)

        do {
            if let taskEntity = try context.fetch(fetchRequest).first {
                context.delete(taskEntity)
                saveContext()
            }
        } catch {
            print("Failed to delete task: \(error)")
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func saveTasksToCoreData(tasks: [Task]) {
        let context = persistentContainer.viewContext

        for task in tasks {
            let newTask = TaskEntity(context: context)
            newTask.id = Int32(task.id)
            newTask.title = task.title
            newTask.taskDescription = task.description
            newTask.completed = task.completed
            newTask.userId = Int32(task.userId)
            newTask.date = task.date
        }

        saveContext()
    }
    
    func saveTask(_ task: Task) {
        let context = persistentContainer.viewContext
        
        let newTask = TaskEntity(context: context)
        newTask.id = Int32(task.id)
        newTask.title = task.title
        newTask.taskDescription = task.description
        newTask.completed = task.completed
        newTask.userId = Int32(task.userId)
        newTask.date = task.date
        
        saveContext()
    }

    func fetchTasksFromCoreData() -> [Task] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()

        do {
            let taskEntities = try context.fetch(fetchRequest)
            return taskEntities.map { taskEntity in
                Task(
                    id: Int(taskEntity.id),
                    title: taskEntity.title ?? "",
                    description: taskEntity.taskDescription ?? "",
                    completed: taskEntity.completed,
                    userId: Int(taskEntity.userId),
                    date: taskEntity.date ?? ""
                )
            }
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
}

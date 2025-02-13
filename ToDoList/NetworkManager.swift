//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Влад Карагодин on 11.02.2025.
//

import Foundation

struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct TodoResponse: Codable {
    let todos: [Todo]
}

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchTodos(completion: @escaping ([Todo]?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let response = try JSONDecoder().decode(TodoResponse.self, from: data)
                completion(response.todos)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }

        task.resume()
    }
}

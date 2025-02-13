//
//  UserDefaultsManager.swift
//  ToDoList
//
//  Created by Влад Карагодин on 13.02.2025.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let hasLaunchedBeforeKey = "hasLaunchedBefore"
    
    private init() {}
    
    var hasLaunchedBefore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasLaunchedBeforeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasLaunchedBeforeKey)
        }
    }
}

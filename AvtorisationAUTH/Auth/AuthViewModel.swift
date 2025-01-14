//
//  AuthViewModel.swift
//  AvtorisationAUTH
//
//  Created by Николай Гринько on 14.01.2025.
//


import UIKit

class AuthViewModel {
    private let userDefaultsKey = "RegisteredUser"
    
    func registerUser(username: String, password: String) -> Bool {
        guard !username.isEmpty, !password.isEmpty else { return false }
        let user = User(username: username, password: password)
        let userData = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(userData, forKey: userDefaultsKey)
        return true
    }
    
    func loginUser(username: String, password: String) -> Bool {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let savedUser = try? JSONDecoder().decode(User.self, from: data) else { return false }
        return savedUser.username == username && savedUser.password == password
    }
    
    func isUserRegistered() -> Bool {
        return UserDefaults.standard.data(forKey: userDefaultsKey) != nil
    }
}

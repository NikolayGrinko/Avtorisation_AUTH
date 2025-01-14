//
//  AuthViewController.swift
//  AvtorisationAUTH
//
//  Created by Николай Гринько on 14.01.2025.
//


import UIKit

class AuthViewController: UIViewController {
    private let viewModel = AuthViewModel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let actionButton = UIButton()
    private let toggleButton = UIButton()
    private var isLoginMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Username Field
        usernameTextField.placeholder = "Логин"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Password Field
        passwordTextField.placeholder = "Пароль"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Action Button
        actionButton.setTitle("Зарегистрироваться", for: .normal)
        actionButton.backgroundColor = .systemBlue
        actionButton.layer.cornerRadius = 8
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        
        // Toggle Button
        toggleButton.setTitle("Уже есть аккаунт? Войти", for: .normal)
        toggleButton.setTitleColor(.systemBlue, for: .normal)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.addTarget(self, action: #selector(toggleMode), for: .touchUpInside)
        
        // Add Subviews
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(actionButton)
        view.addSubview(toggleButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            toggleButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 16),
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func handleAction() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        if isLoginMode {
            if viewModel.loginUser(username: username, password: password) {
                navigateToMain()
            } else {
                showAlert(message: "Неверные данные для входа")
            }
        } else {
            if viewModel.registerUser(username: username, password: password) {
                showAlert(message: "Регистрация успешна")
            } else {
                showAlert(message: "Ошибка регистрации")
            }
        }
    }
    
    @objc private func toggleMode() {
        isLoginMode.toggle()
        actionButton.setTitle(isLoginMode ? "Войти" : "Зарегистрироваться", for: .normal)
        toggleButton.setTitle(isLoginMode ? "Нет аккаунта? Зарегистрироваться" : "Уже есть аккаунт? Войти", for: .normal)
    }
    
    private func navigateToMain() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
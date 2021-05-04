//
//  LoginController.swift
//  InstaFake
//
//  Created by Yersultan Nalikhan on 10.04.2021.
//

import UIKit

protocol AuthenticationDelegate: class {
    func authenticationDidComplete()
}



class LoginController: UIViewController {
    
    //MARK: -PROPERTIES
    
    private var viewModel = LoginViewModel()
    
    weak var delegate : AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white%402x"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextfield: CustomTextfield = {
        let tf = CustomTextfield(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextfield: UITextField = {
        let tf = CustomTextfield(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get help signing in.")
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: -LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    
    //MARK: -HELPERS

    func configureUI() {
        configureGradientLayer()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 42)
        
        let stack = UIStackView(arrangedSubviews: [emailTextfield, passwordTextfield, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top:iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32,paddingLeft: 32 ,paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    
    func configureNotificationObservers() {
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

    }
    
    
    
    
    // MARK: - ACTIONS
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextfield {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc func handleLogin() {
        guard let email = emailTextfield.text else {return}
        guard let password = passwordTextfield.text else {return}
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to log user in \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationDidComplete()
        }
    }
    
    
}


    //MARK: -FormViewModel

extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
    
    
}



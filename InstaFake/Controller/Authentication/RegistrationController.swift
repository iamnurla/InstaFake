//
//  RegistrationController.swift
//  InstaFake
//
//  Created by Yersultan Nalikhan on 10.04.2021.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: -PROPERTIES
    
    private var viewModel = RegistrationViewModel()
    
    private var profileImage: UIImage?
    
    weak var delegate: AuthenticationDelegate?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    private let emailTextfield: CustomTextfield = {
        let tf = CustomTextfield(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let usernameTextField = CustomTextfield(placeholder: "Username")
    private let fullnameTextfield = CustomTextfield(placeholder: "Fullname")
    
    private let passwordTextfield: UITextField = {
        let tf = CustomTextfield(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account? ", secondPart: "Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: -LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationsObservers()
    }
    
    //MARK: -ACTIONS
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }

    
    
    //MARK: -HELPERS
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top:view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        
        let stack = UIStackView(arrangedSubviews: [emailTextfield, usernameTextField,fullnameTextfield,passwordTextfield, signUpButton ])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top:plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32,paddingLeft: 32 ,paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    func configureNotificationsObservers() {
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
    //MARK:     -ACTIONS
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextfield {
            viewModel.email = sender.text
        }else if sender == usernameTextField{ 
            viewModel.username = sender.text
        }else if sender == fullnameTextfield{
            viewModel.fullname = sender.text
        }else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    
    @objc func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextfield.text else {return}
        guard let username = usernameTextField.text?.lowercased()  else {return}
        guard let fullname = fullnameTextfield.text else {return}
        guard let password = passwordTextfield.text else {return}
        guard let profileImage = self.profileImage else {return}
        
        let credentials = AuthCredentials(email: email,
                                          username: username,
                                          fullname: fullname,
                                          password: password,
                                          profileImage: profileImage)

        AuthService.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
    }
    
    
    
}

//MARK: -FormViewModel

extension RegistrationController: FormViewModel {
func updateForm() {
    signUpButton.backgroundColor = viewModel.buttonBackgroundColor
    signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    signUpButton.isEnabled = viewModel.formIsValid
    }
}


    //MARK: -   UIIMagePickerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}

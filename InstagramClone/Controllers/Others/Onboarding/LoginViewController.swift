//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Enes Sirkecioğlu on 24.06.2021.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController{
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }

    
    private let usernameOrEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Kullanıcı Adı veya Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Şifre"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Giriş yap", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Koşullar", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gizlilik", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Yeni hesap oluştur", for: .normal)
        
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(
            self,
            action: #selector(didTapLoginButton),
            for: .touchUpInside)
        createAccountButton.addTarget(
            self,
            action: #selector(didTapCreateAccountButton),
            for: .touchUpInside)
        termsButton.addTarget(
            self,
            action: #selector(didTapTermsButton),
            for: .touchUpInside)
        privacyButton.addTarget(
            self,
            action: #selector(didTapPrivacyButton),
            for: .touchUpInside)
        
        usernameOrEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()

        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: view.height / 3.0
        )
        
        usernameOrEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 20,
            width: view.width - 50,
            height: 52
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameOrEmailField.bottom + 10,
            width: view.width - 50,
            height: 52
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52
        )
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width / 2,
            height: 50
        )
        
        privacyButton.frame = CGRect(
            x: view.width / 2,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width / 2,
            height: 50
        )
        
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        
        backgroundView.frame = headerView.bounds
        
        //Instagram logosu ekleniyor
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: headerView.width / 4,
            y: view.safeAreaInsets.top,
            width: headerView.width / 2,
            height: headerView.height - view.safeAreaInsets.top
        )
    }
    
    private func addSubviews() {
        view.addSubview(usernameOrEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
    }
    
    @objc private func didTapLoginButton(){
        usernameOrEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let usernameOrEmail = usernameOrEmailField.text, !usernameOrEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                return
        }
        
        var username: String?
        var email: String?
        
        if usernameOrEmail.contains("@"), usernameOrEmail.contains(".") {
            email = usernameOrEmail
        } else {
            username = usernameOrEmail
        }
            
        AuthManager.shared.loginUser(
            username: username,
            email: email,
            password: password){ success in
            DispatchQueue.main.async {
                if success {
                    //Kullanici girisi basarili
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    //Kullanici girisi basarisiz
                    let alert = UIAlertController(
                        title: "Giriş işleminde hata",
                        message: "Girişinizi gerçekleştiremedik",
                        preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Kapat", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: true)
                }
            
            
            }
        }
        
    }
    
    
    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    @objc private func didTapCreateAccountButton(){
        let vc = RegistirationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        switch textField {
        case usernameOrEmailField:
            passwordField.becomeFirstResponder()
        default:
            didTapLoginButton()
        }
        
        return true
    }
}

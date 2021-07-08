//
//  ViewController.swift
//  InstagramClone
//
//  Created by Enes Sirkecioğlu on 24.06.2021.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        do {
//            try Auth.auth().signOut()
//        } catch let error as NSError {
//            print("Error signing out \(error)")
//        }
//
        
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated(){
        //Kimlik dogrulamasi
        
        if Auth.auth().currentUser == nil {
            //Login ekranini goster
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            
        }
    }


}


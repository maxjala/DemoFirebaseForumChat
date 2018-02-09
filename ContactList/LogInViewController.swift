//
//  ViewController.swift
//  ContactList
//
//  Created by Max Jala on 08/02/2018.
//  Copyright © 2018 Max Jala. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Skip Login page if user is already logged in
        //check if there is a current user
        if Auth.auth().currentUser != nil {
            
            guard let navVC = self.storyboard?.instantiateViewController(withIdentifier: "navigationController") as? UINavigationController else {return}
            
            present(navVC, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func signInTapped() {
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let validError = error {
                //show Alert
                self.showAlert(withTitle: "Error", message: validError.localizedDescription)
            }
            
            if let validUser = user {
                
                guard let navVC = self.storyboard?.instantiateViewController(withIdentifier: "navigationController") as? UINavigationController else {return}
                
                self.present(navVC, animated: true, completion: nil)
            }
            
        }
    }
    
    @objc func signUpBtnTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {return}
        
        navigationController?.pushViewController(vc, animated: true)
    }


}


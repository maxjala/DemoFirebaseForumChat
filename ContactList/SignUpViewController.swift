//
//  SignUpViewController.swift
//  ContactList
//
//  Created by Max Jala on 08/02/2018.
//  Copyright © 2018 Max Jala. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        }
    }
    
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DatabaseReference is a reference to our specific database
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func signUpUser() {
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text else {return}
        
        //INPUT VALIDATION
        if !email.contains("@") {
            //showerror
            showAlert(withTitle: "Invalid Email Format", message: "Please input a valid email")
        } else if password.count < 7 {
            showAlert(withTitle: "Invalid Password", message: "Password must contain at least 7 characters")
        } else if password != confirmPassword {
            showAlert(withTitle: "Passwords Do Not Match", message: "Passwords must match.")
        } else {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                //ERROR HANDLING
                if let validError = error {
                    self.showAlert(withTitle: "Error", message: validError.localizedDescription)
                }
                
                //HANDLE SUCCESSFUL CREATION OF USER
                if let validUser = user {
                    //do something
                    
                    let userPost : [String:Any] = ["email": email, "age" : arc4random_uniform(20) + 10]
                self.ref.child("users").child(validUser.uid).setValue(userPost)
                    
                    guard let navVC = self.storyboard?.instantiateViewController(withIdentifier: "navigationController") as? UINavigationController else {return}
                    
                    //self.present(navVC, animated: true, completion: nil)
                    self.navigationController?.present(navVC, animated: true, completion: nil)
                    
                    print("SignUp method successful")
                }
                
            })
        }
        
        
    }

}

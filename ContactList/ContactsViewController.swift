//
//  ContactsViewController.swift
//  ContactList
//
//  Created by Max Jala on 08/02/2018.
//  Copyright © 2018 Max Jala. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ContactsViewController: UIViewController {
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            
        }
        
    }
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    var contacts : [User] = []
    
    var ref : DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Chat", style: .plain, target: self, action: #selector(goToChat))
        
        observeFirebase()
    }
    
    func observeFirebase() {
        //observing value returns snapshot of WHOLE VALUE under key ("users")
//        ref.child("users").observe(.value) { (snapshot) in
//
//
//           print("testing")
//        }
        
//        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
//
//
//
//            guard let users = snapshot.value as? [String:Any] else {return}
//
//
//            for (key, value) in users {
//                guard let userDict = value as? [String:Any] else {return}
//
//                let user = User(uid: key, dict: userDict)
//
//                self.contacts.append(user)
//            }
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//
//        }
        
        ref.child("users").observe(.childAdded) { (snapshot) in

            //First time childAdded observer call it loops through all childs (items) under path specified ("users")
            //After this it only observes individual childs added at the moment
            //e.g. if a new person signs up and a new child is added under "users" this function is called.
            
            guard let userDict = snapshot.value as? [String:Any] else {return}
            
            let contact = User(uid: snapshot.key, dict: userDict)

            
            DispatchQueue.main.async {
                self.contacts.append(contact)
                let indexPath = IndexPath(row: self.contacts.count - 1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
            print(snapshot.key)
            
            
            
            
        }
        
        ref.child("users").observe(.childRemoved) { (snapshot) in
            
            print(snapshot.key + " was removed")
        }
        
        ref.child("users").observe(.childChanged) { (snapshot) in
            
            print(snapshot.key)
        }
    }
    
    @objc func goToChat() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else {return}
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ContactsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row].email
        
        return cell
    }
}

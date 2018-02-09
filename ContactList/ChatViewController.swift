//
//  ChatViewController.swift
//  ContactList
//
//  Created by Max Jala on 09/02/2018.
//  Copyright © 2018 Max Jala. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton! {
        didSet {
            sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    var messages : [Message] = []
    
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        fetchMessages()

    }
    
    func fetchMessages() {
        
//        ref.child("chat").observe(.childAdded) { (snapshot) in
//
//            guard let message = snapshot.value as? [String:String] else {return}
//
//            let msg = Message(msgDict: message)
//
//            DispatchQueue.main.async {
//                self.messages.append(msg)
//                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//                self.tableView.insertRows(at: [indexPath], with: .right)
//            }
//
//        }
        
        ref.child("chat").queryOrdered(byChild: "timeStamp").observe(.childAdded) { (snapshot) in
            
            guard let message = snapshot.value as? [String:Any] else {return}
            
            let msg = Message(msgDict: message)
            
            DispatchQueue.main.async {
                self.messages.append(msg)
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .right)
            }
            
        }
    }
    
    @objc func sendMessage() {
        guard let message = inputTextField.text,
            let email = Auth.auth().currentUser?.email else {return}
        
        inputTextField.text = ""
        
        let msgDict : [String:Any] = ["msg":message,"email": email, "timeStamp":Date().timeIntervalSince1970]
        
        ref.child("chat").childByAutoId().setValue(msgDict)
    }

}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].email
        cell.detailTextLabel?.text = messages[indexPath.row].message
        return cell
    }
}

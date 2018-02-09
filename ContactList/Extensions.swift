//
//  Extensions.swift
//  ContactList
//
//  Created by Max Jala on 08/02/2018.
//  Copyright © 2018 Max Jala. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
    }
}

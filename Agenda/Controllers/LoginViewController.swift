//
//  ViewController.swift
//  Agenda
//
//  Created by Jazz on 4/3/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okBtn(_ sender: Any) {
        
        var emailText = emailTF.text
        var passText = passTF.text
        
        if (NetworkManager.shared.checkUser()) {
            
            
        }
        
    }
    
    
}


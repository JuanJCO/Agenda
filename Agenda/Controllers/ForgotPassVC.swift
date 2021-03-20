//
//  ForgotPassVC.swift
//  Agenda
//
//  Created by Jazz on 8/3/21.
//

import Foundation
import UIKit
import Alamofire

class ForgotPassVC: UIViewController{
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        NetworkManager.shared.forgot(email: emailTF.text!, completionHandler: {
            success in
            
            if success {
                self.emailToast(message: "Se ha enviado un email para reestablecer la contraseña", seconds: 1)
            }
        })
    }
    
    func emailToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

//
//  RegisterViewController.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit
import Alamofire

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func createAccBtn(_ sender: Any) {
        
        if (emailTF.hasText && passTF.text == confirmPassTF.text){
            let emailText: String = emailTF.text!
            let passText: String = passTF.text!
            let confirmPassText: String = passTF.text!
            
            print(emailText)
            print(passText)
            print(confirmPassText)
            
            let contactArr: [Contact] = []
                
            NetworkManager.shared.saveUser(userEmail: emailText, userPass: passText, contacts: contactArr)
            
        } else if (passTF.text != confirmPassTF.text){
            let text: String = "La contraseña debe coincidir."
            alert(alertText: text)
        } else {
            let text: String = "Debes rellenar todos los campos."
            alert(alertText: text)
        }
    }
    
    func alert(alertText: String){
        // --- Si no has rellenado los campos, aparece esta alerta
        // create the alert
        let alert = UIAlertController(title: "", message: alertText, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

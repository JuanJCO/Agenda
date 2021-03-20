//
//  Settings.swift
//  Agenda
//
//  Created by Jazz on 10/3/21.
//

import Foundation
import UIKit
import Alamofire

class Settings: UIViewController{
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    override func viewDidLoad() {
        NetworkManager.shared.getUser(completionHandler: { [self]
            user in
            
            if user != nil{
                nameTF.text = user.user.name
                mailTF.text = user.user.email
            }
        })
    }
    
    @IBAction func okBTN(_ sender: Any) {
        if (passTF.hasText && confirmPassTF.hasText){
            let passText: String = passTF.text!
            let confirmPassText: String = confirmPassTF.text!
            
            if (passText == confirmPassText){
                AgendaData.shared.currentUser.userPass = confirmPassText
                NetworkManager.shared.saveUser(userEmail: AgendaData.shared.currentUser.userEmail, userPass: AgendaData.shared.currentUser.userPass, contacts: AgendaData.shared.currentUser.contacts)
                
                showToast(message: "Has cambiado tu contraseña.", seconds: 1.0)
                
                passTF.text = ""
                confirmPassTF.text = ""
            } else {
                alert(message: "Las contraseñas no coinciden.")
            }
        } else {
            alert(message: "Debes rellenar todos los campos.")
        }
    }
    
    @IBAction func deleteAccBTN(_ sender: Any) {
        NetworkManager.shared.deleteUser(completionHandler: {
            success in
            
            if success {
                self.performSegue(withIdentifier: "deleteSegue", sender: Any?.self)
            }
        })
        
    }
    
    func alert(message: String){
        // --- Si no has rellenado los campos, aparece esta alerta
        // create the alert
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}




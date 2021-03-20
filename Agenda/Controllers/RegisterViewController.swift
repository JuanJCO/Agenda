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
    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func createAccBtn(_ sender: Any) {
        
        if (nameTF.hasText && emailTF.hasText && passTF.text == confirmPassTF.text){
            let nameText: String = nameTF.text!
            let emailText: String = emailTF.text!
            let passText: String = passTF.text!
            let confirmPassText: String = passTF.text!

            NetworkManager.shared.register(name: nameText, email: emailText, pass: passText, confirmPass: confirmPassText, completionHandler: {
                    success in
                    
                if success {
                    self.alert(alertText: "Se ha creado un usuario.")
                } else {
                    self.alert(alertText: "Ha habido un error.")
                }
            })

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

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
        
        let emailText = emailTF.text
        let passText = passTF.text
        
        if (emailTF.hasText && passTF.hasText){
            // Comprueba que haya algún elemento 'User'
            if (NetworkManager.shared.checkUser()) {
                AgendaData.shared.currentUser = NetworkManager.shared.getUser()
                // Comprueba que los datos introducidos coincidan con los de 'User'
                if (emailText == AgendaData.shared.currentUser.userEmail && passText == AgendaData.shared.currentUser.userPass){
                    self.performSegue(withIdentifier: "contactsSegue", sender: Any?.self)
                } else {
                    alert(alertText: "El e-mail o la contraseña no corresponden a ningún usuario.")
                }
            }
        } else {
            alert(alertText: "Debes rellenar todos los campos.")
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


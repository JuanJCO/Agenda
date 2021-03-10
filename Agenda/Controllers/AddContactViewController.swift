//
//  AddContactViewController.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit
import Alamofire

class AddContactViewController: UIViewController{
    
    var addContact: UIButton?
    var nameText: String = ""
    var phoneText: String = ""
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if (nameTF.hasText && phoneTF.hasText) {
            
            nameText = nameTF.text!
            phoneText = phoneTF.text!
            
            // Creo un nuevo contacto y lo guardo en el currentUser y el 'user' guardado en las Defaults
            let newContact = Contact(contactName: nameText, contactPhone: phoneText)
            
            AgendaData.shared.currentUser.contacts.append(newContact)
            NetworkManager.shared.saveUser(userEmail: AgendaData.shared.currentUser.userEmail, userPass: AgendaData.shared.currentUser.userPass, contacts: AgendaData.shared.currentUser.contacts)
            
            self.showToast(message: "Has añadido un contacto.", seconds: 1.0)
            
        } else {
            alert()
        }
    }
    
    func alert(){
        // --- Si no has rellenado los campos, aparece esta alerta
        // create the alert
        let alert = UIAlertController(title: "", message: "Debes rellenar todos los campos.", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController{
    // Cuando añades el contacto, aparece este "toast"
    func showToast(message : String, seconds: Double){
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

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
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if (nameTF.hasText && phoneTF.hasText) {
            // SPINNER
            let activityIndicator = UIActivityIndicatorView(style: .white) // Create the activity indicator
            view.addSubview(activityIndicator) // add it as a  subview
            activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.75) // put in the middle
            activityIndicator.startAnimating() // Start animating
            // SPINNER
            
            let nameText = nameTF.text!
            let phoneText = phoneTF.text!
            let mailText = mailTF.text!
            
            NetworkManager.shared.newContact(name: nameText, phone: phoneText, mail: mailText, completionHandler: { [self]
                    success in
                
                if success {
                    self.showToast(message: "Has añadido un contacto.", seconds: 0.5)
                    nameTF.text = nil
                    phoneTF.text = nil
                    mailTF.text = nil
                    
                    NetworkManager.shared.showContacts(completionHandler: {
                        contacts in
                        
                        ContactClass.shared.contactsArray = contacts
                        activityIndicator.stopAnimating()
                    })
                } else {
                    self.alert(alertText: "Ha habido un error.")
                }
            })
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

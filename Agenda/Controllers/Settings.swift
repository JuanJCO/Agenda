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
        // SPINNER
        let activityIndicator = UIActivityIndicatorView(style: .white) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.75) // put in the middle
        activityIndicator.startAnimating() // Start animating
        // SPINNER
        
        NetworkManager.shared.getUser(completionHandler: { [self]
            user in
            
            if user != nil{
                nameTF.text = user.user.name
                mailTF.text = user.user.email
                activityIndicator.stopAnimating()
            }
        })
    }
    
    @IBAction func okBTN(_ sender: Any) {
        
        print("entra")
        
        if (passTF.hasText && confirmPassTF.hasText){
            if (passTF.text == confirmPassTF.text){
                UserData.shared.password = passTF.text!
                
                updateUserRequest()
            } else {
                alert(message: "Las contraseñas no coinciden.")
            }
        }
        if (passTF.hasText && !confirmPassTF.hasText || !passTF.hasText && confirmPassTF.hasText){
            alert(message: "Las contraseñas no coinciden.")
        }
        
        print("sin contrasena")
        updateUserRequest()
    }
    
    func updateUserRequest(){
        // SPINNER
        let activityIndicator = UIActivityIndicatorView(style: .white) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.75) // put in the middle
        activityIndicator.startAnimating() // Start animating
        // SPINNER
        
        NetworkManager.shared.updateUser(name: nameTF.text!, mail: mailTF.text!, password: UserData.shared.password, completionHandler: {
            success in
            
            if success {
                print(self.nameTF.text)
                self.showToast(message: "Has actualizado tus datos", seconds: 1)
                activityIndicator.stopAnimating()
                
            }
        })
    }
    
    @IBAction func deleteAccBTN(_ sender: Any) {
        // SPINNER
        let activityIndicator = UIActivityIndicatorView(style: .white) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.75) // put in the middle
        activityIndicator.startAnimating() // Start animating
        // SPINNER
        
        NetworkManager.shared.deleteUser(completionHandler: {
            success in
            
            if success {
                activityIndicator.stopAnimating()
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




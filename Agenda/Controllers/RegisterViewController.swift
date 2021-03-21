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
    
    @IBAction func createAccBtn(_ sender: UIButton) {
        //SPINNER
        disableView()
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large) // Create the spinner
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.color = UIColor.white
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
        activityIndicator.startAnimating() // Start animating
        //SPINNER
        
        if (nameTF.hasText && emailTF.hasText && passTF.hasText && passTF.text == confirmPassTF.text){
            let nameText: String = nameTF.text!
            let emailText: String = emailTF.text!
            let passText: String = passTF.text!
            let confirmPassText: String = passTF.text!

            NetworkManager.shared.register(name: nameText, email: emailText, pass: passText, confirmPass: confirmPassText, completionHandler: {
                    success in
                    
                if success {
                    activityIndicator.stopAnimating()
                    self.ableView()
                    print("Se ha creado el usuario")
                    self.performSegue(withIdentifier: "registerSegue", sender: Any?.self)
                } else {
                    self.ableView()
                    activityIndicator.stopAnimating()
                    self.alert(alertText: "La contraseña debe contener, al menos, 6 carácteres")
                }
                self.ableView()
                activityIndicator.stopAnimating()
            })

        } else if (passTF.text != confirmPassTF.text){
            let text: String = "La contraseña debe coincidir."
            alert(alertText: text)
            self.ableView()
            activityIndicator.stopAnimating()
        } else {
            let text: String = "Debes rellenar todos los campos."
            alert(alertText: text)
            self.ableView()
            activityIndicator.stopAnimating()
        }
        self.ableView()
        activityIndicator.stopAnimating()
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
    
    func disableView(){
        view.isUserInteractionEnabled = false
        view.alpha = 0.5
    }
    
    func ableView(){
        view.isUserInteractionEnabled = true
        view.alpha = 1
    }
}

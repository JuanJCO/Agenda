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
        
        //SPINNER
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large) // Create the spinner
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.color = UIColor.black
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
        disableView()
        activityIndicator.startAnimating() // Start animating
        
        // SPINNER
        
        let emailText = emailTF.text
        let passText = passTF.text
        
        if (emailTF.hasText && passTF.hasText){
            // Comprueba que haya algún elemento 'User'
    
            NetworkManager.shared.login(email: emailText!, pass: passText!, completionHandler: {
                success in
                
                if success {
                    activityIndicator.stopAnimating()
                    UserData.shared.password = self.passTF.text!
                    self.ableView()
                    self.performSegue(withIdentifier: "contactsSegue", sender: Any?.self)
                } else {
                    self.alert(alertText: "No se ha encontrado ningún usuario con ese mail y/o contraseña.")
                    self.ableView()
                    activityIndicator.stopAnimating()
                }
            })
        } else {
            alert(alertText: "Debes rellenar todos los campos.")
            self.ableView()
            activityIndicator.stopAnimating()
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
    
    func disableView(){
        view.isUserInteractionEnabled = false
        view.alpha = 0.5
    }
    
    func ableView(){
        view.isUserInteractionEnabled = true
        view.alpha = 1
    }
}


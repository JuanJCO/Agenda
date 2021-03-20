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
        // SPINNER
        let activityIndicator = UIActivityIndicatorView(style: .white) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.75) // put in the middle
        activityIndicator.startAnimating() // Start animating
        // SPINNER
        
        if (emailTF.hasText){
            NetworkManager.shared.forgot(email: emailTF.text!, completionHandler: {
                success in
                
                if success {
                    self.emailToast(message: "Se ha enviado un email para reestablecer la contraseña", seconds: 1)
                    activityIndicator.stopAnimating()
                }
            })
        } else {
            alert(alertText: "Debes introducir un correo electrónico")
            activityIndicator.stopAnimating()
        }

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

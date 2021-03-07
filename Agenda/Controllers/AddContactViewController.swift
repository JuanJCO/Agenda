//
//  AddContactViewController.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit

class AddContactViewController: UIViewController{
    
    var addContact: UIButton?
    var nameText: String = ""
    var phoneText: String = ""
    var nameArray: [String] = []
    var phoneArray: [String] = []
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        
        if (nameTF.hasText && phoneTF.hasText) {
            // Text field is not empty
            nameText = nameTF.text!
            phoneText = phoneTF.text!
            
            nameArray.append(nameText)
            phoneArray.append(phoneText)
            
            print(nameArray)
            print(phoneArray)
            
        } else {
            // --- Si no has rellenado los campos, aparece esta alerta
            // create the alert
            let alert = UIAlertController(title: "", message: "Debes rellenar todos los campos.", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MainViewController {
            let vc = segue.destination as? MainViewController
            vc?.nameArray.append(contentsOf: nameArray)
            vc?.phoneArray.append(contentsOf: phoneArray)
        }
    }
}

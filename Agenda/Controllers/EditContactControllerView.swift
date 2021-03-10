//
//  EditContactControllerView.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit

class EditContactControllerView: UIViewController, UITextFieldDelegate{
    
    var nameText: String = ""
    var phoneText: String = ""
    var row: Int?
    
    var editNameB: Bool = false
    var editPhoneB: Bool = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.delegate = self
        phoneTF.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        row = AgendaData.shared.row
        
        nameTF.isHidden = true
        phoneTF.isHidden = true
        
        nameLabel.text = AgendaData.shared.currentUser.contacts[row!].contactName
        phoneLabel.text = AgendaData.shared.currentUser.contacts[row!].contactPhone
        
    }
    
    @IBAction func nameBtn(_ sender: UIButton) {
        // Cambio el estado de las booleanas
        editNameB.toggle()
        nameLabel.isHidden.toggle()
        nameTF.isHidden.toggle()
        
        if (editNameB){
            // Cambio la imagen del botón por un Check y activo el Textfield para escribir sin hacer click en él
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            nameTF.becomeFirstResponder()
        } else{
            // Asigno el texto del TextField al Label y almaceno los datos en el array de la clase Data
            nameText = nameTF.text!
            nameLabel.text = nameText
            nameTF.text = nameLabel.text
            
            AgendaData.shared.currentUser.contacts[row!].contactName = nameText
            
            sender.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
    }
    
    @IBAction func phoneBtn(_ sender: UIButton) {
        // Cambio el estado de las booleanas
        editPhoneB.toggle()
        phoneLabel.isHidden.toggle()
        phoneTF.isHidden.toggle()
        
        if (editPhoneB){
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            phoneTF.becomeFirstResponder()
        } else{
            phoneText = phoneTF.text!
            phoneLabel.text = phoneText
            phoneTF.text = phoneLabel.text
            
            AgendaData.shared.currentUser.contacts[row!].contactPhone = phoneText
            
            sender.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        AgendaData.shared.currentUser.contacts.remove(at: row!)
        
        NetworkManager.shared.saveUser(userEmail: AgendaData.shared.currentUser.userEmail, userPass: AgendaData.shared.currentUser.userPass, contacts: AgendaData.shared.currentUser.contacts)
        
    }
    
    
}

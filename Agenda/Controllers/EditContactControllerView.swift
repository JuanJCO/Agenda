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
    var mailText: String = ""
    
    var row: Int?
    
    var editNameB: Bool = false
    var editPhoneB: Bool = false
    var editMailB: Bool = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var mailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.delegate = self
        phoneTF.delegate = self
        mailTF.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        row = AgendaData.shared.row
        
        nameTF.isHidden = true
        phoneTF.isHidden = true
        mailTF.isHidden = true
        
        nameLabel.text = ContactClass.shared.contactsArray[row!].name
        phoneLabel.text = ContactClass.shared.contactsArray[row!].phone
        mailLabel.text = ContactClass.shared.contactsArray[row!].mail
        
    }
    
    @IBAction func nameBtn(_ sender: UIButton) {
        // Cambio el estado de las booleanas
        editNameB.toggle()
        nameLabel.isHidden.toggle()
        nameTF.isHidden.toggle()
        
        if (editNameB){
            nameTF.text = nameLabel.text
            // Cambio la imagen del botón por un Check y activo el Textfield para escribir sin hacer click en él
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            nameTF.becomeFirstResponder()
        } else{
            // Asigno el texto del TextField al Label y almaceno los datos en el array de la clase Data
            nameText = nameTF.text!
            nameLabel.text = nameText
            nameTF.text = nameLabel.text
            
            ContactClass.shared.contactsArray[row!].name = nameText
            
            sender.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
    }
    
    @IBAction func phoneBtn(_ sender: UIButton) {
        // Cambio el estado de las booleanas
        editPhoneB.toggle()
        phoneLabel.isHidden.toggle()
        phoneTF.isHidden.toggle()
    
        
        if (editPhoneB){
            phoneTF.text = phoneLabel.text
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            phoneTF.becomeFirstResponder()
        } else{
            phoneText = phoneTF.text!
            phoneLabel.text = phoneText
            phoneTF.text = phoneLabel.text
            
            ContactClass.shared.contactsArray[row!].phone = phoneText
            
            sender.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
    }
    
    @IBAction func mailBtn(_ sender: UIButton) {
        // Cambio el estado de las booleanas
        editMailB.toggle()
        mailLabel.isHidden.toggle()
        mailTF.isHidden.toggle()
        
        
        if (editMailB){
            mailTF.text = mailLabel.text
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            mailTF.becomeFirstResponder()
        } else{
            mailText = mailTF.text!
            mailLabel.text = mailText
            mailTF.text = mailLabel.text
            
            ContactClass.shared.contactsArray[row!].mail = mailText
            
            sender.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        NetworkManager.shared.deleteContact(id: ContactClass.shared.contactsArray[row!].id, completionHandler: {
            success in
            
            if success {
                self.performSegue(withIdentifier: "deleteContactSegue", sender: Any?.self)
            }

        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NetworkManager.shared.editContact(id: ContactClass.shared.contactsArray[row!].id , name: ContactClass.shared.contactsArray[row!].name, phone: ContactClass.shared.contactsArray[row!].phone, mail: ContactClass.shared.contactsArray[row!].mail, completionHandler: {
                success in
        })
    }
    
    
}

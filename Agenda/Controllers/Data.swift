//
//  Data.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import Alamofire

struct User: Codable {
    let id: Int
    let userEmail: String
    var userPass: String
    let apiToken: String
    var contacts: Contacts
    
    enum CodingKeys: String, CodingKey {
        case id
        case userEmail = "user_Email"
        case userPass = "user_Pass"
        case apiToken = "api_Token"
        case contacts
        
    }
}

// TypeAlias: Al llamar a 'Contacts', entiende que estoy llamando a un array de la struct Contact
typealias Contacts = [Contact]

struct Contact: Codable {
    var contactName: String
    var contactPhone: String
    
    enum CodingKeys: String, CodingKey{
        case contactName = "contact_Name"
        case contactPhone = "contact_Phone"
    }
}

class AgendaData{
    static var shared: AgendaData  = AgendaData()
    
    var currentUser: User = User(id: 0, userEmail: "usuarioNoVálido", userPass: "", apiToken: "", contacts: [])
    var row: Int?
    
}




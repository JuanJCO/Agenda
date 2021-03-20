//
//  Contact.swift
//  Agenda
//
//  Created by Jazz on 19/3/21.
//

import Foundation

// MARK: - ContactElement
struct ContactElement: Codable {
    let id: Int
    var name, phone, mail: String
    let userID: Int
//    let contactImage: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name, phone, mail
        case userID = "user_id"
//        case contactImage = "contact_image"
    }
}

class ContactClass{
    static var shared: ContactClass  = ContactClass()
    
    var contactsArray: [ContactElement] = []
}

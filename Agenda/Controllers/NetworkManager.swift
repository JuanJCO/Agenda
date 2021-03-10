//
//  NetworkManager.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static var shared: NetworkManager = NetworkManager()
    let defaults = UserDefaults.standard
    
    
    
    func saveUser (userEmail: String, userPass: String, contacts: Contacts){
        let user = User(id: 1, userEmail: userEmail, userPass: userPass, apiToken: "apiToken", contacts: contacts)
        
        // try sin "?" requiere un catch.
        // Con "!" te lo fuerza.
        // Con "?", si no lo puede codificar, continúa el código.
        let encodedUser = try? JSONEncoder().encode(user)
        self.defaults.setValue(encodedUser, forKey: "user")
    }
    
    func checkUser () -> Bool {
        if (self.defaults.object(forKey: "user") != nil){
            return true
        } else {
            return false
        }
    }
    
    func getUser() -> User {
        
        // Sirve para devolver un usuario temporal, si no entra en la condición
        var tempUser = User(id: 0, userEmail: "usuarioNoVálido", userPass: "", apiToken: "", contacts: [])
       
        let currentUser: Data = self.defaults.object(forKey: "user") as! Data
        if let decodedUser = try? JSONDecoder().decode(User.self, from: currentUser){
            return decodedUser
        }
        return tempUser
    }
}


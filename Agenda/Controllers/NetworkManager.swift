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
    let url = URL(string: "APIUrl")
    let apiKey = "APIKey"
    
    // ----------
    // DEFAULT
    // ----------
    
    // Guarda el usuario en Defaults
    func saveUser (userEmail: String, userPass: String, contacts: Contacts){
        let user = User(id: 1, userEmail: userEmail, userPass: userPass, apiToken: "apiToken", contacts: contacts)
        
        // try sin "?" requiere un catch.
        // Con "!" te lo fuerza.
        // Con "?", si no lo puede codificar, continúa el código.
        let encodedUser = try? JSONEncoder().encode(user)
        self.defaults.setValue(encodedUser, forKey: "user")
    }
    
    // Comprueba si existe un usuario dentro de Defaults y devuelve una bool
    func checkUser () -> Bool {
        if (self.defaults.object(forKey: "user") != nil){
            return true
        } else {
            return false
        }
    }
    
    // Recupera el usuario de Defaults si checkUser() es true
    func getUser() -> User {
        // Sirve para devolver un usuario temporal, si no entrase en la condición
        var tempUser = User(id: 0, userEmail: "usuarioNoVálido", userPass: "", apiToken: "", contacts: [])
        let currentUser: Data = self.defaults.object(forKey: "user") as! Data
        if let decodedUser = try? JSONDecoder().decode(User.self, from: currentUser){
            return decodedUser
        }
        return tempUser
    }
    
    // --------------------
    // CAPA DE RED (Peticiones)
    // --------------------
    
    func login(user: String, pass: String) {
        let queryParameters = [
                "user": user,
                "pass": pass]
            
            AF.request(self.url as! URLConvertible, method: .get, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseDecodable(of: User.self){
                response in
            }
        }
        
    func register(user: String, pass: String){
        let queryParameters = [
            "user": user,
            "pass": pass]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseDecodable(of: User.self){
            response in
        }
    }
    
    func newPass(newPass: String){
        let queryParameters = [
            "pass": newPass]
        
        let headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
        }
    }
    
    func newContact(contact: Contact){
        let queryParameters = [
            "contact": contact]
        
        let headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
        }
    }
    
    func editContact(contactAt: Int, contact: Contact){
        let queryParameters = [
            "contact_At": contactAt,
            "contact": contact] as [String : Any]
        
        let headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
        }
    }
    
    func deleteContact(contactAt: Int){
        let queryParameters = [
            "contact_At": contactAt]
        
        let headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
        }
    }
    
    func deleteUser(contactAt: Int){
        let queryParameters = [
            "contact_At": contactAt]
        
        let headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: String.self){
            response in
        }
    }
}


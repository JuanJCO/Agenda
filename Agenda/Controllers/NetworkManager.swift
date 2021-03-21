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
    let url = "https://agenda-app-service.herokuapp.com/api/"
    var token = ""
    
    // --------------------
    // CAPA DE RED (Peticiones)
    // --------------------
    
    func register(name: String, email:String, pass: String, confirmPass: String, completionHandler: @escaping(Bool)->Void){

        let registerUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/register")

        let user: [String:Any] = ["name": name, "email": email, "password": pass, "password_confirmation": confirmPass]

        let jsonContact = try? JSONSerialization.data(
            withJSONObject: user, options: [])
        print("jsonContact", jsonContact)
        
        var request = URLRequest(url: registerUrl!)

        request.httpMethod = "POST"

        request.httpBody = jsonContact
        request.headers = ["Content-Type": "application/json"]

        AF.request(request).validate(statusCode: 200..<300).response { response in
            debugPrint("response",response)

            if(response.error == nil){
                do {
                    let user = try JSONDecoder().decode(Login.self, from: response.data!)
                    self.token = user.token
                    print(self.token)
                    completionHandler(true)
                } catch {
                }
            }else{
                completionHandler(false)
            }
        }
    }
    
    func login(email: String, pass: String, completionHandler: @escaping(Bool)->Void) {
        
        let queryParameters = [
                "email": email,
                "password": pass]
            
        let loginUrl = URL(string: url + "login")
        AF.request(loginUrl!, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: nil).validate().response {
                response in
            
                if (response.error == nil){
                    do {
                        let user = try JSONDecoder().decode(Login.self, from: response.data!)
                        self.token = user.token
                        print(self.token)
                        completionHandler(true)
                    } catch {
                    }
                } else {
                    completionHandler(false)
                }
            }
    }
    
    func updateUser(name: String, mail: String, password: String, completionHandler: @escaping(Bool) -> Void) {
        let updateUserUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/update")

        let contact: [String:Any] = ["name": name, "mail": mail, "password": password]

        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact, options: [])

        var request = URLRequest(url: updateUserUrl!)

        request.httpMethod = "POST"

        request.httpBody = jsonContact

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().response { response in
        debugPrint(response)

            if(response.error == nil){
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }
    
    func newContact(name: String, phone: String, mail: String, completionHandler: @escaping(Bool)->Void) {
        
        let newContactUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/create")

        let contact: [String:Any] = ["name": name, "mail": mail, "phone": phone]

        print(register)

        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact)

        var request = URLRequest(url: newContactUrl!)

        request.httpMethod = "POST"

        request.httpBody = jsonContact

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().responseJSON  { response in
        debugPrint(response)

            if(response.error == nil){
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }
    
    func showContacts(completionHandler: @escaping([ContactElement])->Void) {

        let showContactsURL = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/index")
        var contact: [ContactElement] = []

        var request = URLRequest(url: showContactsURL!)

        request.httpMethod = "GET"

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().responseJSON {
            response in

            debugPrint("response",response)

            if (response.error == nil) {
                do {
                    contact = try JSONDecoder().decode([ContactElement].self, from: response.data!)
                    debugPrint(contact)
                    completionHandler(contact)

                } catch {
                    print("no hay contactos")
                }
            }
        }
    }

    func editContact(id:Int, name: String, phone: String, mail: String, completionHandler: @escaping(Bool)->Void) {

        let stringId = String(id)

        let editContactUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/update/"+stringId)

        let contact: [String:Any] = ["name": name, "mail": mail, "phone": phone]

        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact)

        var request = URLRequest(url: editContactUrl!)
        
        request.httpMethod = "POST"

        request.httpBody = jsonContact

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().responseJSON  { response in
        debugPrint(response)

            if(response.error == nil){
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }
    
    func deleteContact(id:Int, completionHandler: @escaping(Bool)->Void) {
 
        let editContactUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/delete")

        let contact: [String:Any] = ["id": id]

        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact)

        var request = URLRequest(url: editContactUrl!)

        request.httpMethod = "POST"

        request.httpBody = jsonContact

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().responseJSON  { response in
        debugPrint(response)

            if(response.error == nil){
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }

    func getUser(completionHandler: @escaping (UserElement) -> Void) {
        let getUserUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/user")

        var request = URLRequest(url: getUserUrl!)

        request.httpMethod = "GET"

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().responseJSON  { response in
        debugPrint(response)


            do {
                let user = try JSONDecoder().decode(UserElement.self, from: response.data!)
                debugPrint(user)
                completionHandler(user)
            
            } catch {
                print("no hay contactos")
            }
        }
    }
    
    func deleteUser(completionHandler: @escaping (Bool) -> Void){

        let deleteUserUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/deleteUser")

        var request = URLRequest(url: deleteUserUrl!)

        request.httpMethod = "POST"

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().responseJSON  { response in
        debugPrint(response)

            if(response.error == nil){
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }
    
    func forgot(email: String,completionHandler: @escaping(Bool)->Void){
        struct forgot: Encodable {
                    let email: String
                }

        let url = URL(string: "https://agenda-app-service.herokuapp.com/api/password/email")

        let contact: [String:Any] = [ "email": email]

        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: contact,
            options: [])

        var request = URLRequest(url: url!)

        request.httpMethod = "POST"

        request.httpBody = jsonLogin

        request.headers = ["Content-Type": "application/json"]

        AF.request(request).validate().response()
            { response in

            debugPrint(response)

            if(response.error == nil){

                completionHandler(true)

            }else {

                completionHandler(false)

            }
        }
    }
    
    func searchContact(search: String, completionHandler: @escaping ([ContactElement]) -> Void){
        
        let searchContactUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/search")
        var contact: [ContactElement] = []
        
        var request = URLRequest(url: searchContactUrl!)

        request.httpMethod = "GET"

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]
        
        AF.request(request).validate().responseJSON {
            response in
            
            debugPrint("response",response)
            
            if (response.error == nil) {
                do {
                    contact = try JSONDecoder().decode([ContactElement].self, from: response.data!)
                    debugPrint(contact)
                    completionHandler(contact)
                
                } catch {
                    print("No se han encontrado contactos")
                }
            }
        }
        
    }
}


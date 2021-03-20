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

        //alamcenamos la URL de la api en una varianle
        let registerUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/register")

        //preparamos las variables a enviar
        let user: [String:Any] = ["name": name, "email": email, "password": pass, "password_confirmation": confirmPass]


        //las transformamos en JSON
        let jsonContact = try? JSONSerialization.data(
            withJSONObject: user, options: [])
        print("jsonContact", jsonContact)
        
        //llamamos a la request, dandole la url
        var request = URLRequest(url: registerUrl!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"

        //se le indica el contenido del body
        request.httpBody = jsonContact
        request.headers = ["Content-Type": "application/json"]
        
        //se envia la peticion usando alamofire
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

        //preparamos las variables a enviar
        let contact: [String:Any] = ["name": name, "mail": mail, "password": password]

        //las transformamos en JSON
        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact, options: [])

        //llamamos a la request, dandole la url
        var request = URLRequest(url: updateUserUrl!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"

        //se le indica el contenido del body
        request.httpBody = jsonContact

        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        //se envia la peticion usando alamofire
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
        struct Contact: Encodable {
            let name: String
            let mail: String
            let phone: String
        }

        //alamcenamos la URL de la api en una varianle
        let newContactUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/create")

        //preparamos las variables a enviar
        let contact: [String:Any] = ["name": name, "mail": mail, "phone": phone]

        print(register)

        //las transformamos en JSON
        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact)

        //llamamos a la request, dandole la url
        var request = URLRequest(url: newContactUrl!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"

        //se le indica el contenido del body
        request.httpBody = jsonContact

        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        //se envia la peticion usando alamofire
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

        //se le indica el protocolo con el que se envia
        request.httpMethod = "GET"

        //el header
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
        struct Contact: Encodable {
            let name: String
            let mail: String
            let phone: String
        }

        let stringId = String(id)
        //alamcenamos la URL de la api en una varianle
        let editContactUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/update/"+stringId)

        //preparamos las variables a enviar
        let contact: [String:Any] = ["name": name, "mail": mail, "phone": phone]

        //las transformamos en JSON
        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact)

        //llamamos a la request, dandole la url
        var request = URLRequest(url: editContactUrl!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"

        //se le indica el contenido del body
        request.httpBody = jsonContact

        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        //se envia la peticion usando alamofire
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
        //alamcenamos la URL de la api en una varianle
        let editContactUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/contact/delete")

        //preparamos las variables a enviar
        let contact: [String:Any] = ["id": id]

        //las transformamos en JSON
        let jsonContact = try? JSONSerialization.data(
        withJSONObject: contact)

        //llamamos a la request, dandole la url
        var request = URLRequest(url: editContactUrl!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"

        //se le indica el contenido del body
        request.httpBody = jsonContact

        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        //se envia la peticion usando alamofire
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


        //llamamos a la request, dandole la url
        var request = URLRequest(url: getUserUrl!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "GET"

        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        //se envia la peticion usando alamofire
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
        //alamcenamos la URL de la api en una varianle
        let deleteUserUrl = URL(string: "https://agenda-app-service.herokuapp.com/api/deleteUser")

        //llamamos a la request, dandole la url
        var request = URLRequest(url: deleteUserUrl!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"

        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        //se envia la peticion usando alamofire
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

        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://agenda-app-service.herokuapp.com/api/password/email")

        //preparamos las variables a enviar
        let contact: [String:Any] = [ "email": email]

        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: contact,
            options: [])

        //llamamos a la request, dandole la url
        var request = URLRequest(url: url!)

        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"

        //se le indica el contenido del body
        request.httpBody = jsonLogin

        //el header
        request.headers = ["Content-Type": "application/json"]

        //se envia la peticion usando alamofire
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

        //se le indica el protocolo con el que se envia
        request.httpMethod = "GET"

        //el header
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


//
//  NetworkManager.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    /*var APIKey = "****"
    let GoogleAPIKey = "AIzaSyDk9iPMv0vXSZgTTrRU1O0UR3AyfA7c5A0"
    let url = "https://contacts-bd.herokuapp.com/api"
    var authResponse : Any = ""
    //var foodResponse : Foods?
    
    let decoder = JSONDecoder()
    
    static var shared: NetworkManager = NetworkManager()
    
    func registerUser(email: String, password: String) -> Any {
    
        let registerURL = self.url + "/users/register"
        let registerParameters =
            [
                "email" : email,
                "password" : password
        ]
        
        AF.request(registerURL, method: .post, parameters: registerParameters)
            .validate()
            .responseDecodable(of: UserResponse.self){ (response) in
                guard let registerResponse = response.value else { return }
                if(registerResponse.status == "OK"){
                    self.APIKey = registerResponse.APIKey
                    self.authResponse = registerResponse.status
                }else if(registerResponse.status == "password"){
                    self.authResponse = registerResponse.status
                }else{
                    self.authResponse = registerResponse.status
                }
            }
        return self.authResponse
    }
    
    func loginUser(email: String, password: String) -> Any {
        
        let loginURL = self.url + "/users/login"
        let loginParameters =
            [
            "email" : email,
            "password" : password
        ]
        
        AF.request(loginURL, method: .post, parameters: loginParameters)
            .validate()//Checks is return HTTPstatus code in 200-299
            .responseDecodable(of: UserResponse.self ){ (response)  in
                guard let loginResponse = response.value else { return }
                if(loginResponse.status == "OK"){
                    self.APIKey = loginResponse.APIKey
                    self.authResponse = loginResponse.status
                }else if(loginResponse.status == "password"){
                    self.authResponse = loginResponse.status
                }else{
                    self.authResponse = loginResponse.status
                }
            }
        return self.authResponse*/
    }


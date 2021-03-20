// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - User
struct UserElement: Codable {
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let name, email: String

    enum CodingKeys: String, CodingKey {
        case id, name, email

    }
}

class UserData{
    static var shared: UserData  = UserData()
    
    var password = ""
    
}

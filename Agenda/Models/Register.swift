// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let register = try? newJSONDecoder().decode(Register.self, from: jsonData)

import Foundation

// MARK: - Register
struct RegisterUser: Codable {
    let UserRegister: UserRegister
    let token: String
}

// MARK: - User
struct UserRegister: Codable {
    let name, email: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, email
        case id
    }
}



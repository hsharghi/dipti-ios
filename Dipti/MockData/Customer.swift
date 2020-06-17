//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

// MARK: - Customer
class Customer: Codable {
    var id: Int
    var email, emailCanonical, firstName, lastName: String
    var gender: String
    var user: User?

    enum CodingKeys: String, CodingKey {
        case id, email, emailCanonical, firstName, lastName, gender, user
    }

    init(id: Int, email: String, emailCanonical: String, firstName: String, lastName: String, gender: String, user: User? = nil) {
        self.id = id
        self.email = email
        self.emailCanonical = emailCanonical
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.user = user
    }
}

// MARK: Customer convenience initializers and mutators

extension Customer {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Customer.self, from: data)
        self.init(id: me.id, email: me.email, emailCanonical: me.emailCanonical, firstName: me.firstName, lastName: me.lastName, gender: me.gender, user: me.user)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        email: String? = nil,
        emailCanonical: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        gender: String? = nil,
        user: User? = nil
    ) -> Customer {
        return Customer(
            id: id ?? self.id,
            email: email ?? self.email,
            emailCanonical: emailCanonical ?? self.emailCanonical,
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName,
            gender: gender ?? self.gender,
            user: user ?? self.user
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


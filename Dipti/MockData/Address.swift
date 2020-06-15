//
//  Address.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

// MARK: - Address
class Address: Codable {
    var id: Int
    var firstName, lastName, countryCode, street: String
    var phoneNumber: String?
    var city, postcode: String
    var createdAt, updatedAt: Date

    init(id: Int, firstName: String, lastName: String, countryCode: String, street: String, city: String, postcode: String, phoneNumber: String? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.countryCode = countryCode
        self.street = street
        self.city = city
        self.postcode = postcode
        self.phoneNumber = phoneNumber
        self.createdAt = createdAt ?? Date()
        self.updatedAt = updatedAt ?? Date()
    }
}

// MARK: Address convenience initializers and mutators

extension Address {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Address.self, from: data)
        self.init(id: me.id, firstName: me.firstName, lastName: me.lastName, countryCode: me.countryCode, street: me.street, city: me.city, postcode: me.postcode, phoneNumber: me.phoneNumber, createdAt: me.createdAt, updatedAt: me.updatedAt)
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
        firstName: String? = nil,
        lastName: String? = nil,
        countryCode: String? = nil,
        street: String? = nil,
        city: String? = nil,
        postcode: String? = nil,
        phoneNumber: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) -> Address {
        return Address(
            id: id ?? self.id,
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName,
            countryCode: countryCode ?? self.countryCode,
            street: street ?? self.street,
            city: city ?? self.city,
            postcode: postcode ?? self.postcode,
            phoneNumber: phoneNumber ?? self.phoneNumber,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


extension Address: Equatable {
    static func == (lhs: Address, rhs: Address) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}

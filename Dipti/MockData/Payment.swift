//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

// MARK: - Payment
class Payment: Codable {
    var id: Int
    var method: PaymentMethod
    var amount: Int
    var state: String
    var createdAt, updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id, method, amount, state, createdAt, updatedAt
    }

    init(id: Int, method: PaymentMethod, amount: Int, state: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.method = method
        self.amount = amount
        self.state = state
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: Payment convenience initializers and mutators

extension Payment {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Payment.self, from: data)
        self.init(id: me.id, method: me.method, amount: me.amount, state: me.state, createdAt: me.createdAt, updatedAt: me.updatedAt)
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
        method: PaymentMethod? = nil,
        amount: Int? = nil,
        state: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) -> Payment {
        return Payment(
            id: id ?? self.id,
            method: method ?? self.method,
            amount: amount ?? self.amount,
            state: state ?? self.state,
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


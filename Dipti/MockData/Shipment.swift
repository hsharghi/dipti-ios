//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

// MARK: - Shipment
class Shipment: Codable {
    var id: Int
    var state: String
    var method: ShipmentMethod
    var createdAt, updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id, state, method, createdAt, updatedAt
    }

    init(id: Int, state: String, method: ShipmentMethod, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.state = state
        self.method = method
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: Shipment convenience initializers and mutators

extension Shipment {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Shipment.self, from: data)
        self.init(id: me.id, state: me.state, method: me.method, createdAt: me.createdAt, updatedAt: me.updatedAt)
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
        state: String? = nil,
        method: ShipmentMethod? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) -> Shipment {
        return Shipment(
            id: id ?? self.id,
            state: state ?? self.state,
            method: method ?? self.method,
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


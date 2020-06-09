//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


// MARK: - Channel
class Channel: Codable {
    var id: Int
    var code, name, hostname, color: String
    var createdAt, updatedAt: Date
    var enabled: Bool
    var taxCalculationStrategy: String

    enum CodingKeys: String, CodingKey {
        case id, code, name, hostname, color, createdAt, updatedAt, enabled, taxCalculationStrategy
    }

    init(id: Int, code: String, name: String, hostname: String, color: String, createdAt: Date, updatedAt: Date, enabled: Bool, taxCalculationStrategy: String) {
        self.id = id
        self.code = code
        self.name = name
        self.hostname = hostname
        self.color = color
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.enabled = enabled
        self.taxCalculationStrategy = taxCalculationStrategy
    }
}

// MARK: Channel convenience initializers and mutators

extension Channel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Channel.self, from: data)
        self.init(id: me.id, code: me.code, name: me.name, hostname: me.hostname, color: me.color, createdAt: me.createdAt, updatedAt: me.updatedAt, enabled: me.enabled, taxCalculationStrategy: me.taxCalculationStrategy)
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
        code: String? = nil,
        name: String? = nil,
        hostname: String? = nil,
        color: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        enabled: Bool? = nil,
        taxCalculationStrategy: String? = nil
    ) -> Channel {
        return Channel(
            id: id ?? self.id,
            code: code ?? self.code,
            name: name ?? self.name,
            hostname: hostname ?? self.hostname,
            color: color ?? self.color,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            enabled: enabled ?? self.enabled,
            taxCalculationStrategy: taxCalculationStrategy ?? self.taxCalculationStrategy
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


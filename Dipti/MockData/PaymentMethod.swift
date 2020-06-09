//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


// MARK: - PaymentMethod
class PaymentMethod: Codable {
    var id: Int
    var code: String
    var createdAt, updatedAt: Date
    var channels: [Channel]

    enum CodingKeys: String, CodingKey {
        case id, code, createdAt, updatedAt, channels
    }

    init(id: Int, code: String, createdAt: Date, updatedAt: Date, channels: [Channel]) {
        self.id = id
        self.code = code
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.channels = channels
    }
}

// MARK: PaymentMethod convenience initializers and mutators

extension PaymentMethod {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PaymentMethod.self, from: data)
        self.init(id: me.id, code: me.code, createdAt: me.createdAt, updatedAt: me.updatedAt, channels: me.channels)
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
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        channels: [Channel]? = nil
    ) -> PaymentMethod {
        return PaymentMethod(
            id: id ?? self.id,
            code: code ?? self.code,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            channels: channels ?? self.channels
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


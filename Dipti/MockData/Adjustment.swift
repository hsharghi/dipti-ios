//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


// MARK: - Adjustment
class Adjustment: Codable {
    var id: Int
    var type, label: String
    var amount: Int

    init(id: Int, type: String, label: String, amount: Int) {
        self.id = id
        self.type = type
        self.label = label
        self.amount = amount
    }
}

// MARK: Adjustment convenience initializers and mutators

extension Adjustment {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Adjustment.self, from: data)
        self.init(id: me.id, type: me.type, label: me.label, amount: me.amount)
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
        type: String? = nil,
        label: String? = nil,
        amount: Int? = nil
    ) -> Adjustment {
        return Adjustment(
            id: id ?? self.id,
            type: type ?? self.type,
            label: label ?? self.label,
            amount: amount ?? self.amount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


// MARK: - ShipmentMethod
class ShipmentMethod: Codable {
    var id: Int
    var code: String
    var categoryRequirement: Int
    var calculator: String
    var createdAt, updatedAt: Date
    var enabled: Bool

    enum CodingKeys: String, CodingKey {
        case id, code
        case categoryRequirement = "category_requirement"
        case calculator, createdAt, updatedAt, enabled
    }

    init(id: Int, code: String, categoryRequirement: Int, calculator: String, createdAt: Date, updatedAt: Date, enabled: Bool) {
        self.id = id
        self.code = code
        self.categoryRequirement = categoryRequirement
        self.calculator = calculator
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.enabled = enabled
    }
}

// MARK: ShipmentMethod convenience initializers and mutators

extension ShipmentMethod {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ShipmentMethod.self, from: data)
        self.init(id: me.id, code: me.code, categoryRequirement: me.categoryRequirement, calculator: me.calculator, createdAt: me.createdAt, updatedAt: me.updatedAt, enabled: me.enabled)
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
        categoryRequirement: Int? = nil,
        calculator: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        enabled: Bool? = nil
    ) -> ShipmentMethod {
        return ShipmentMethod(
            id: id ?? self.id,
            code: code ?? self.code,
            categoryRequirement: categoryRequirement ?? self.categoryRequirement,
            calculator: calculator ?? self.calculator,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            enabled: enabled ?? self.enabled
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

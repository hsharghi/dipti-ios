//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

// MARK: - OptionValue
class OptionValue: Codable {
    var name, code: String

    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}

// MARK: OptionValue convenience initializers and mutators

extension OptionValue {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OptionValue.self, from: data)
        self.init(name: me.name, code: me.code)
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
        name: String? = nil,
        code: String? = nil
    ) -> OptionValue {
        return OptionValue(
            name: name ?? self.name,
            code: code ?? self.code
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


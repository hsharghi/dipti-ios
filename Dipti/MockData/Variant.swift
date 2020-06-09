//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


// MARK: - Variant
class Variant: Codable {
    var id: Int
    var code: String
    var optionValues: [OptionValue]
    var position: Int
    var translations: Translations
    var version, onHold, onHand: Int
    var tracked: Bool

    enum CodingKeys: String, CodingKey {
        case id, code, optionValues, position, translations, version, onHold, onHand, tracked
    }

    init(id: Int, code: String, optionValues: [OptionValue], position: Int, translations: Translations, version: Int, onHold: Int, onHand: Int, tracked: Bool) {
        self.id = id
        self.code = code
        self.optionValues = optionValues
        self.position = position
        self.translations = translations
        self.version = version
        self.onHold = onHold
        self.onHand = onHand
        self.tracked = tracked
    }
}

// MARK: Variant convenience initializers and mutators

extension Variant {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Variant.self, from: data)
        self.init(id: me.id, code: me.code, optionValues: me.optionValues, position: me.position, translations: me.translations, version: me.version, onHold: me.onHold, onHand: me.onHand, tracked: me.tracked)
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
        optionValues: [OptionValue]? = nil,
        position: Int? = nil,
        translations: Translations? = nil,
        version: Int? = nil,
        onHold: Int? = nil,
        onHand: Int? = nil,
        tracked: Bool? = nil
    ) -> Variant {
        return Variant(
            id: id ?? self.id,
            code: code ?? self.code,
            optionValues: optionValues ?? self.optionValues,
            position: position ?? self.position,
            translations: translations ?? self.translations,
            version: version ?? self.version,
            onHold: onHold ?? self.onHold,
            onHand: onHand ?? self.onHand,
            tracked: tracked ?? self.tracked
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


// MARK: - Translations
class Translations: Codable {
    var enUS, faIR: TranslationLocale

    enum CodingKeys: String, CodingKey {
        case enUS = "en_US"
        case faIR = "fa_IR"
    }

    init(enUS: TranslationLocale, faIR: TranslationLocale) {
        self.enUS = enUS
        self.faIR = faIR
    }
}

// MARK: Translations convenience initializers and mutators

extension Translations {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Translations.self, from: data)
        self.init(enUS: me.enUS, faIR: me.faIR)
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
        enUS: TranslationLocale? = nil,
        faIR: TranslationLocale? = nil
    ) -> Translations {
        return Translations(
            enUS: enUS ?? self.enUS,
            faIR: faIR ?? self.faIR
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - EnUs
class TranslationLocale: Codable {
    var locale: String
    var id: Int
    var name: String

    init(locale: String, id: Int, name: String) {
        self.locale = locale
        self.id = id
        self.name = name
    }
}

// MARK: EnUs convenience initializers and mutators

extension TranslationLocale {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TranslationLocale.self, from: data)
        self.init(locale: me.locale, id: me.id, name: me.name)
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
        locale: String? = nil,
        id: Int? = nil,
        name: String? = nil
    ) -> TranslationLocale {
        return TranslationLocale(
            locale: locale ?? self.locale,
            id: id ?? self.id,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

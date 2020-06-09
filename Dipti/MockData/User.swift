//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

// MARK: - User
class User: Codable {
    var id: Int
    var username, usernameCanonical: String
    var roles: [String]
    var enabled: Bool

    init(id: Int, username: String, usernameCanonical: String, roles: [String], enabled: Bool) {
        self.id = id
        self.username = username
        self.usernameCanonical = usernameCanonical
        self.roles = roles
        self.enabled = enabled
    }
}

// MARK: User convenience initializers and mutators

extension User {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(User.self, from: data)
        self.init(id: me.id, username: me.username, usernameCanonical: me.usernameCanonical, roles: me.roles, enabled: me.enabled)
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
        username: String? = nil,
        usernameCanonical: String? = nil,
        roles: [String]? = nil,
        enabled: Bool? = nil
    ) -> User {
        return User(
            id: id ?? self.id,
            username: username ?? self.username,
            usernameCanonical: usernameCanonical ?? self.usernameCanonical,
            roles: roles ?? self.roles,
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


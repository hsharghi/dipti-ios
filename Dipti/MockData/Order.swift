//
//  Order.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

// MARK: - Order
class Order: Codable {
    var id: Int
    var checkoutCompletedAt: Date
    var number: String
    var items: [Item]
    var itemsTotal: Int
    var adjustments: [Adjustment]
    var adjustmentsTotal, total: Int
    var state: String
    var customer: Customer
    var channel: Channel
    var shippingAddress, billingAddress: Address
    var payments: [Payment]
    var shipments: [Shipment]
    var currencyCode, localeCode, checkoutState: String

    init(id: Int, checkoutCompletedAt: Date, number: String, items: [Item], itemsTotal: Int, adjustments: [Adjustment], adjustmentsTotal: Int, total: Int, state: String, customer: Customer, channel: Channel, shippingAddress: Address, billingAddress: Address, payments: [Payment], shipments: [Shipment], currencyCode: String, localeCode: String, checkoutState: String) {
        self.id = id
        self.checkoutCompletedAt = checkoutCompletedAt
        self.number = number
        self.items = items
        self.itemsTotal = itemsTotal
        self.adjustments = adjustments
        self.adjustmentsTotal = adjustmentsTotal
        self.total = total
        self.state = state
        self.customer = customer
        self.channel = channel
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
        self.payments = payments
        self.shipments = shipments
        self.currencyCode = currencyCode
        self.localeCode = localeCode
        self.checkoutState = checkoutState
    }
}

// MARK: Order convenience initializers and mutators

extension Order {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Order.self, from: data)
        self.init(id: me.id, checkoutCompletedAt: me.checkoutCompletedAt, number: me.number, items: me.items, itemsTotal: me.itemsTotal, adjustments: me.adjustments, adjustmentsTotal: me.adjustmentsTotal, total: me.total, state: me.state, customer: me.customer, channel: me.channel, shippingAddress: me.shippingAddress, billingAddress: me.billingAddress, payments: me.payments, shipments: me.shipments, currencyCode: me.currencyCode, localeCode: me.localeCode, checkoutState: me.checkoutState)
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
        checkoutCompletedAt: Date? = nil,
        number: String? = nil,
        items: [Item]? = nil,
        itemsTotal: Int? = nil,
        adjustments: [Adjustment]? = nil,
        adjustmentsTotal: Int? = nil,
        total: Int? = nil,
        state: String? = nil,
        customer: Customer? = nil,
        channel: Channel? = nil,
        shippingAddress: Address? = nil,
        billingAddress: Address? = nil,
        payments: [Payment]? = nil,
        shipments: [Shipment]? = nil,
        currencyCode: String? = nil,
        localeCode: String? = nil,
        checkoutState: String? = nil
    ) -> Order {
        return Order(
            id: id ?? self.id,
            checkoutCompletedAt: checkoutCompletedAt ?? self.checkoutCompletedAt,
            number: number ?? self.number,
            items: items ?? self.items,
            itemsTotal: itemsTotal ?? self.itemsTotal,
            adjustments: adjustments ?? self.adjustments,
            adjustmentsTotal: adjustmentsTotal ?? self.adjustmentsTotal,
            total: total ?? self.total,
            state: state ?? self.state,
            customer: customer ?? self.customer,
            channel: channel ?? self.channel,
            shippingAddress: shippingAddress ?? self.shippingAddress,
            billingAddress: billingAddress ?? self.billingAddress,
            payments: payments ?? self.payments,
            shipments: shipments ?? self.shipments,
            currencyCode: currencyCode ?? self.currencyCode,
            localeCode: localeCode ?? self.localeCode,
            checkoutState: checkoutState ?? self.checkoutState
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



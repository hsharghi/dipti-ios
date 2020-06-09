//
//  Order.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

// MARK: - Order
class Order: Models, Codable {
    
    enum OrderState: String, Codable {
            case    cart    //Unconfirmed order, ready to add/remove items
            case    new    //Confirmed order
            case    cancelled    //Cancelled by customer or manager
            case    fulfilled    //Order has been fulfilled
    }
    
    enum CheckoutState: String, Codable {
        case cart
        case addressed
        case shipping_selected
        case payment_selected
        case completed
    }
    
    enum CodingKeys: String, CodingKey {
        case id, checkoutCompletedAt, number, items, itemsTotal, adjustments, adjustmentsTotal, total, customer, channel, shippingAddress, billingAddress, payments, shipments, currencyCode, localeCode
        case state = "__state"  // unused key
        case checkoutState = "__checkoutState"  // unused key
        case stateString = "state"
        case checkoutStateString = "checkoutState"
    }
    
    var id: Int
    var checkoutCompletedAt: Date
    var number: String
    var items: [OrderItem]
    var itemsTotal: Int
    var adjustments: [Adjustment]?
    var adjustmentsTotal, total: Int
    var state: OrderState
    var stateString: String
    var checkoutState: CheckoutState
    var checkoutStateString: String
    var customer: Customer?
    var channel: Channel?
    var shippingAddress, billingAddress: Address?
    var payments: [Payment]?
    var shipments: [Shipment]?
    var currencyCode, localeCode: String

    init(id: Int, checkoutCompletedAt: Date, number: String, items: [OrderItem], itemsTotal: Int, adjustments: [Adjustment]? = nil, adjustmentsTotal: Int? = nil, total: Int, state: OrderState, customer: Customer? = nil, channel: Channel? = nil, shippingAddress: Address? = nil, billingAddress: Address? = nil, payments: [Payment]? = nil, shipments: [Shipment]? = nil, currencyCode: String, localeCode: String, checkoutState: CheckoutState) {
        self.id = id
        self.checkoutCompletedAt = checkoutCompletedAt
        self.number = number
        self.items = items
        self.itemsTotal = itemsTotal
        self.adjustments = adjustments
        self.adjustmentsTotal = adjustments == nil ? total : (adjustmentsTotal ?? total)
        self.total = total
        self.state = state
        self.stateString = state.rawValue
        self.customer = customer
        self.channel = channel
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
        self.payments = payments
        self.shipments = shipments
        self.currencyCode = currencyCode
        self.localeCode = localeCode
        self.checkoutState = checkoutState
        self.checkoutStateString = checkoutState.rawValue
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
        items: [OrderItem]? = nil,
        itemsTotal: Int? = nil,
        adjustments: [Adjustment]? = nil,
        adjustmentsTotal: Int? = nil,
        total: Int? = nil,
        state: OrderState? = nil,
        customer: Customer? = nil,
        channel: Channel? = nil,
        shippingAddress: Address? = nil,
        billingAddress: Address? = nil,
        payments: [Payment]? = nil,
        shipments: [Shipment]? = nil,
        currencyCode: String? = nil,
        localeCode: String? = nil,
        checkoutState: CheckoutState? = nil
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



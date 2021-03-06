//
//  OrderItem.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

// MARK: - OrderItem
class OrderItem: Codable {
    var id: String
    var quantity, unitPrice, total: Int
    var adjustments: [Adjustment]?
    var adjustmentsTotal: Int?
    var variant: Variant?
    
    // temporary
    var designer: String?
    var productName: String?
    var imageName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, quantity, unitPrice, total, adjustments, adjustmentsTotal, variant, designer, productName, imageName
    }
    
    init(id: String, quantity: Int, unitPrice: Int, total: Int, adjustments: [Adjustment]? = nil, adjustmentsTotal: Int? = nil, variant: Variant? = nil, designer: String? = nil, productName: String? = nil, imageName: String? = nil) {
        self.id = id
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.total = total
        self.adjustments = adjustments
        self.adjustmentsTotal = adjustments == nil ? total : adjustmentsTotal
        self.variant = variant
        self.designer = designer
        self.productName = productName
        self.imageName = imageName
    }
}

// MARK: OrderItem convenience initializers and mutators

extension OrderItem {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OrderItem.self, from: data)
        self.init(id: me.id, quantity: me.quantity, unitPrice: me.unitPrice, total: me.total, adjustments: me.adjustments, adjustmentsTotal: me.adjustmentsTotal, variant: me.variant, designer: me.designer, productName: me.productName, imageName: me.imageName)
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
        id: String? = nil,
        quantity: Int? = nil,
        unitPrice: Int? = nil,
        total: Int? = nil,
        adjustments: [Adjustment]? = nil,
        adjustmentsTotal: Int? = nil,
        variant: Variant? = nil,
        designer: String? = nil,
        productName: String? = nil,
        imageName: String? = nil
    ) -> OrderItem {
        return OrderItem(
            id: id ?? self.id,
            quantity: quantity ?? self.quantity,
            unitPrice: unitPrice ?? self.unitPrice,
            total: total ?? self.total,
            adjustments: adjustments ?? self.adjustments,
            adjustmentsTotal: adjustmentsTotal ?? self.adjustmentsTotal,
            variant: variant ?? self.variant,
            designer: designer ?? self.designer,
            productName: productName ?? self.productName,
            imageName: imageName ?? self.imageName
        )
    }
    
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    func relatedProduct() -> Product? {
        return AppData.appDelegate.mockFactory.products.filter({$0.id == self.id}).first
    }
}

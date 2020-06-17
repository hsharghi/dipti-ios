//
//  CustomerRepository.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/17/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


class CustomerRepository {
    
    class func register(email: String, firstName: String, lastName: String, gender: String) -> Customer {
        let customer = Customer(id: Int.random(in: 100_000...999_999), email: email, emailCanonical: email, firstName: firstName, lastName: lastName, gender: gender)
        var customers = AppData.registeredCustomers
        customers.append(customer)
        AppData.registeredCustomers = customers
        return customer
    }
    
    class func login(email: String) -> Customer? {
        return AppData.registeredCustomers.filter({$0.email == email}).first
    }
    
    class func update(customer: Customer) {
        var customers = AppData.registeredCustomers
        if let existingCustomer = customers.filter({$0 == customer}).first {
            customers.replace(object: existingCustomer, with: customer)
        }
        AppData.customer = customer
    }
    
}

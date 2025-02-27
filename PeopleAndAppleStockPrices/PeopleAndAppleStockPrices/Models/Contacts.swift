//
//  Contacts.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Results: Codable {
    let contacts: [Contact]
    
    static func getContacts(from data: Data) -> [Contact] {
        do {
            let contactResults = try JSONDecoder().decode(Results.self, from: data)
            return contactResults.contacts
        } catch let decodeError {
            fatalError("Error: \(decodeError)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case contacts = "results"
    }
    
    static func getSearchResults(contactArr: [Contact], search: String?) -> [Contact] {
        guard let search = search else {return contactArr}
        guard search != "" else {return contactArr}
        
        return contactArr.filter{$0.fullName.contains(search)
        }
        
    }
    
}


struct Contact: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let phone: String
    let cell: String
    var fullName: String {get {
        return "\(name.first) \(name.last)"
        }
    }
    
    struct NameWrapper: Codable {
        let first: String
        let last: String
    }
    
    struct LocationWrapper: Codable {
        let street: String
        let city: String
        let state: String
    }
    
   
}

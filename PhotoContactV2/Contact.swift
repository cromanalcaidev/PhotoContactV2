//
//  Contact.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 1/6/24.
//

import Foundation

struct Contact: Codable, Comparable, Hashable, Identifiable {
    let id: UUID
    var name: String
    var surname: String
    var pic: Data?
    var phoneNumber: Int
    
    static func <(lhs: Contact, rhs: Contact) -> Bool {
        lhs.surname < rhs.surname
    }
}

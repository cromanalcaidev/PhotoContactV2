//
//  Contact.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 1/6/24.
//

import Foundation
import MapKit

struct Contact: Codable, Comparable, Hashable, Identifiable {
    let id: UUID
    var name: String
    var surname: String
    var pic: Data?
    var phoneNumber: Int
    var latitude: Double
    var longitude: Double
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func <(lhs: Contact, rhs: Contact) -> Bool {
        lhs.surname < rhs.surname
    }
}

//
//  Contacts.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 1/6/24.
//

import Foundation

@Observable
class Contacts {
    var contactList = [Contact]() {
        didSet {
            save()
        }
    }
    
    let savePath = URL.documentsDirectory.appending(path: "SavedContacts")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            contactList = try JSONDecoder().decode([Contact].self, from: data)
        } catch {
            contactList = []
        }
        
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(contactList)
            try data.write(to: savePath)
        } catch {
            print("Unable to save data.")
        }
    }
}

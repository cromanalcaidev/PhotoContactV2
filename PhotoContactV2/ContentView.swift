//
//  ContentView.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 1/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var contacts = Contacts()
    @State private var enableAddContact = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts.contactList.sorted()) { contact in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(contact.name) \(contact.surname)")
                                .fontWeight(.bold)
                            Text("\(contact.phoneNumber)")
                        }
                        
                        Spacer()
                        
                        NavigationLink("", value: contact)
                    }
                    .navigationDestination(for: Contact.self) { contact in
                        Text("Hello")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("My contacts")
            .toolbar {
                ToolbarItem {
                    Button("Add more contacts", systemImage: "plus.circle.fill") {
                        enableAddContact.toggle()
//                        contacts.contactList = []
                    }
                }
            }
            .sheet(isPresented: $enableAddContact) {
                AddContactView(contacts: contacts)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        contacts.contactList.remove(atOffsets: offsets)
    }
    
}

#Preview {
    ContentView()
}


//
//  ListView.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 2/6/24.
//

import SwiftUI

struct ListView: View {
    @State private var contacts = Contacts()
    @State private var enableAddContact = false
    @State private var isTapped = false
    
    @Binding var isGrid: Bool
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts.contactList.sorted()) { contact in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(contact.name) \(contact.surname)")
                                .fontWeight(.bold)
                            if contact.phoneNumber == 0 {
                                Text("")
                            } else {
                                Text("\(contact.phoneNumber)")
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink("", value: contact)
                    }
                    .navigationDestination(for: Contact.self) { contact in
                        ContactDetailView(contactName: contact.name,
                                          contactSurname: contact.surname,
                                          contactPic: contact.pic,
                                          contactPhoneNumber: contact.phoneNumber)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Photo Contact")
            .navigationBarTitleTextColor(.black)
            .toolbar {
                ToolbarItem {
                    Button("Add more contacts", systemImage: "plus.circle") {
                        enableAddContact.toggle()
//                        contacts.contactList = []
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button() {
                        withAnimation {
//                            contacts.contactList = []
                            isGrid = true
                        }
                    } label: {
                        Image(systemName: "rectangle.grid.2x2")
                            .foregroundColor(.blue)
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
    ListView(isGrid: .constant(false))
}

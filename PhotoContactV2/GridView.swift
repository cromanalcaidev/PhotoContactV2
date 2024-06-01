//
//  GridView.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 1/6/24.
//

import PhotosUI
import SwiftUI

struct GridView: View {
    @State private var contacts = Contacts()
    @State private var enableAddContact = false
    
    @State private var selectedImageData: Data?
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                        ForEach(contacts.contactList.sorted()) { contact in
                            NavigationLink {
                                AddContactView(contacts: contacts)
                            } label: {
                                VStack {
                                    if let imageData = contact.pic,
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 140)
                                            .clipShape(.circle)
                                            .padding()
                                    }
                                    
                                    VStack(alignment: .center) {
                                        Text("\(contact.name)\n \(contact.surname)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        
                                        Text("\(contact.phoneNumber)")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle (cornerRadius: 10)
                                        .stroke(.secondary)
                                )
                            }
                        }
                        .padding([.horizontal, .bottom])
//                        .onDelete(perform: removeItems)
                }
                .sheet(isPresented: $enableAddContact) {
                    AddContactView(contacts: contacts)
                }
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
        }
    }
    func removeItems(at offsets: IndexSet) {
        contacts.contactList.remove(atOffsets: offsets)
    }
}

#Preview {
    GridView()
}

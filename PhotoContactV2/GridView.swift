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
    @Binding var isGrid: Bool
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(stops: [
                    Gradient.Stop(color: .mint, location: 0.15),
                    Gradient.Stop(color: .teal, location: 0.35),
                    Gradient.Stop(color: .cyan, location: 0.55),
                    Gradient.Stop(color: .blue, location: 0.75),
                    Gradient.Stop(color: .indigo, location: 0.95)
                ], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                            ForEach(contacts.contactList.sorted()) { contact in
                                NavigationLink {
                                    ContactDetailView(contactName: contact.name,
                                                      contactSurname: contact.surname,
                                                      contactPic: contact.pic,
                                                      contactPhoneNumber: contact.phoneNumber, latitude: contact.latitude, longitude: contact.longitude)
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
                                            Text("\(contact.name) \(contact.surname)")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                            
                                            Text("\(contact.phoneNumber)")
                                                .font(.caption)
                                                .foregroundStyle(.white)
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                    }
                                    .background(.regularMaterial)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle (cornerRadius: 10)
                                            .stroke(.secondary)
                                    )
                                    
                                }
                            }
                            .padding([.horizontal, .bottom])
                    }
                    .sheet(isPresented: $enableAddContact) {
                        AddContactView(contacts: contacts)
                    }
                }
                .navigationTitle("Photo Contact")
                .navigationBarTitleTextColor(.white)
                .toolbar {
                    ToolbarItem {
                        Button() {
                            enableAddContact.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button() {
                            withAnimation {
                                isGrid = false
                            }
                        } label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GridView(isGrid: .constant(false))
}

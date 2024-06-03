//
//  AddContactView.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 1/6/24.
//

import PhotosUI
import SwiftUI

struct AddContactView: View {
    var contacts: Contacts
    
    @State private var contactName = ""
    @State private var contactSurname = ""
    @State var phoneNumber = ""
    @State private var showAlert = false
    
    @State var pickerItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var isCircle = false
    
    let locationFetcher = LocationFetcher()
    
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                PhotosPicker(selection: $pickerItem,
                             matching: .images,
                             photoLibrary: .shared()) {
                    
                    if let imageData = selectedImageData,
                       let uiImage = UIImage(data: imageData) {
                        Section {
                            if isCircle {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 300, maxHeight: 300)
                                    .clipShape(.circle)
                                    .padding(.vertical, 20)
                            } else {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 300, maxHeight: 300)
                                    .clipShape(.circle)
                                    .opacity(0.3)
                                    .padding(.vertical, 20)
                            }
                        }
                        
                        Section {
                            
                            HStack {
                                Button(role: .destructive) {
                                    withAnimation {
                                        pickerItem = nil
                                        selectedImageData = nil
                                    }
                                } label: {
                                    Label("Remove image", systemImage: "xmark")
                                        .foregroundStyle(.red)
                                }
                                .padding(.leading, 10)
                            
                                Spacer()
                                
                                Button(role: .cancel) {
                                    isCircle.toggle()
                                    locationFetcher.start()
                                    
                                    if let location = locationFetcher.lastKnownLocation {
                                        latitude = location.latitude
                                        longitude = location.longitude
                                    }
                                    
                                    print(latitude)
                                    print(longitude)
                                } label: {
                                    Label("Save image", systemImage: "photo.badge.checkmark")
                                        .foregroundStyle(.blue)
                                }
                                .padding(.trailing, 10)
                            }
                            .padding(.bottom, 20)
                        }
                        .alert("Please add the contact details", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        }
                    } else {
                        Label("Add picture", systemImage: "photo")
                    }
                }
                .task(id: pickerItem) {
                     if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                         selectedImageData = data
                     }
                 }
                
                if selectedImageData != nil {
                    Section("Contact name") {
                        TextField("Name", text: $contactName)
                        TextField("Last name", text: $contactSurname)
                    }
                    
                    Section("Phone number") {
                        TextField("Phone number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save contact", systemImage: "square.and.arrow.down") {
                        if contactName.isEmpty {
                            showAlert = true
                        } else if contactSurname.isEmpty {
                            showAlert = true
                        } else if phoneNumber.isEmpty {
                            showAlert = true
                        } else {
                            saveContact()
                        }
                    }
                }
            }
        }
    }
    func saveContact() {
        let newContact = Contact(id: UUID(), name: contactName, surname: contactSurname, pic: selectedImageData, phoneNumber: Int(phoneNumber) ?? 00000, latitude: latitude, longitude: longitude)
        contacts.contactList.append(newContact)
        dismiss()
    }
}

#Preview {
    AddContactView(contacts: Contacts())
}


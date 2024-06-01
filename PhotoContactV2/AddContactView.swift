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
    
    @State var pickerItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
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
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .clipShape(.circle)
                                .padding(.vertical, 20)
                        }
                        
                        Section {
                            
                            Button(role: .destructive) {
                                withAnimation {
                                    pickerItem = nil
                                    selectedImageData = nil
                                }
                            } label: {
                                Label("Remove image", systemImage: "xmark")
                                    .foregroundStyle(.red)
                            }
                            .padding(.bottom, 20)
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
                        saveContact()
                    }
                }
            }
        }
    }
    func saveContact() {
        let newContact = Contact(id: UUID(), name: contactName, surname: contactSurname, pic: selectedImageData, phoneNumber: Int(phoneNumber) ?? 00000)
        contacts.contactList.append(newContact)
        dismiss()
    }
}

#Preview {
    AddContactView(contacts: Contacts())
}


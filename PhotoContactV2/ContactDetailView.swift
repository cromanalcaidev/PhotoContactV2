//
//  ContactDetailView.swift
//  PhotoContactV2
//
//  Created by Carlos Román Alcaide on 2/6/24.
//

import MapKit
import PhotosUI
import SwiftUI

struct ContactDetailView: View {
    
    var contactName: String
    var contactSurname: String
    var contactPic: Data?
    var contactPhoneNumber: Int
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: .mint, location: 0.15),
                Gradient.Stop(color: .teal, location: 0.35),
                Gradient.Stop(color: .cyan, location: 0.55),
                Gradient.Stop(color: .blue, location: 0.75),
                Gradient.Stop(color: .indigo, location: 0.95)
            ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                if contactPic == nil {
                    Image("you")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 170)
                        .clipShape(.circle)
                        .padding()
                } else {
                    if let contactPic,
                       let uiImage = UIImage(data: contactPic) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .clipShape(.circle)
                            .padding()
                    }
                }
                
                Divider()
                    .overlay(.black)
                    .padding()
                    .frame(width: 300)
                
                VStack {
                    Text("\(contactName)\n\(contactSurname)")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("\(contactPhoneNumber)")
                }
                
                Divider()
                    .overlay(.black)
                    .padding()
                    .frame(width: 300)
                
                VStack {
                    Section("You met them here:") {
                        Map(interactionModes: [])
                            .padding(.horizontal, 20)
                        .mapStyle(.standard(elevation: .realistic))
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 600)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            .padding()
        }
            
    }
}

#Preview {
    ContactDetailView(contactName: "Pepe", contactSurname: "Pindangas", contactPhoneNumber: 1234567)
}

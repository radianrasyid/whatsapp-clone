//
//  WhatsappContactDetailsListComp.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 07/07/24.
//

import Foundation
import SwiftUI

struct WhatsappContactDetailsListComp: View {
    @Binding var lockChat: Bool
    var photosAmount: Int
    var starredMessages: Int
    
    var body: some View {
        VStack(alignment: .leading){
            Button{
                print("medias")
            }label: {
                HStack{
                    Image(systemName: "photo")
                    Text("Media, links and docs")
                    
                    Spacer()
                    
                    Text("\(photosAmount)")
                        .foregroundStyle(Color(.systemGray))
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(.systemGray))
                }
            }
            
            Divider()
            
            Button{
                print("starred chats")
            }label: {
                HStack{
                    Image(systemName: "star")
                    Text("Starred messages")
                    
                    Spacer()
                    
                    Text(starredMessages == 0 ? "None" : "\(starredMessages)")
                        .foregroundStyle(Color(.systemGray))
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(.systemGray))
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 10))
        
        VStack(alignment: .leading){
            Button{
                print("notifications")
            }label: {
                HStack{
                    Image(systemName: "bell")
                    Text("Notifications")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(.systemGray))
                }
            }
            
            Divider()
            
            Button{
                print("wallpaper")
            }label: {
                HStack{
                    Image(systemName: "camera.aperture")
                    Text("Wallpaper")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(.systemGray))
                }
            }
            
            Divider()
            
            Button{
                print("save to photos")
            }label: {
                HStack{
                    Image(systemName: "square.and.arrow.down")
                    Text("Save to Photos")
                    
                    Spacer()
                    
                    Text("Default")
                        .foregroundStyle(Color(.systemGray))
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(.systemGray))
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 10))
        
        VStack(alignment: .leading){
            Button{
                print("encryption")
            }label: {
                HStack{
                    Image(systemName: "lock")
                    VStack(alignment: .leading){
                        Text("Encryption")
                        Text("Message and calls are end-to-end encrypted. Tap to verify.")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(.systemGray))
                }
            }
            
            Divider()
            
            Button{
                print("disappearing messages")
            }label: {
                HStack{
                    Image(systemName: "timer")
                    Text("Disappearing messages")
                    Spacer()
                    Text("Off")
                        .foregroundStyle(Color(.systemGray))
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(.systemGray))
                }
            }
            
            Divider()
            
            HStack{
                Image(systemName: "lock.shield")
                VStack(alignment: .leading){
                    Text("Lock chat")
                    Text("Lock and hide this chat on this device.")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray))
                }
                Spacer()
                Toggle("", isOn: $lockChat)
                    .frame(width: 50)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 10))
        
        Button{
            print("contact details")
        }label: {
            HStack{
                Image(systemName: "person.crop.circle")
                Text("Contact details")
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(.systemGray))
            }
        }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(.rect(cornerRadius: 10))
    }
}

//
//  WhatsappCallsCreateLink.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappCallsCreateLink: View {
    @Binding var createLinkSheet: Bool
    @Binding var callType: String
    var body: some View {
        NavigationStack{
            List{
                Section{
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            HStack{
                                ZStack{
                                    Rectangle()
                                        .foregroundStyle(Color(.systemGray3))
                                        .frame(width: 65, height: 65)
                                        .clipShape(.rect(cornerRadius: 10))
                                    
                                    Image(systemName: "video.fill")
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Video call")
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.label))
                                    
                                    Button{
                                        print("link copied")
                                    }label: {
                                        Text("http://call.whatsapp.com/video/xxxxxxxxxxxxxx")
                                            .foregroundStyle(Color(.accent))
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                    }
                                    
                                }
                            }
                            
                            Text("Anyone with WhatsApp can use this link to join this call. Only share it with people you trust")
                                .font(.caption)
                                .foregroundStyle(Color(.label))
                        }
                        
                        Divider()
                        
                        Menu{
                            Button{
                                callType = "Video"
                            }label: {
                                HStack{
                                    Text("Video")
                                    Spacer()
                                    Image(systemName: "video")
                                }
                            }
                            
                            Button{
                                callType = "Voice"
                            }label: {
                                HStack{
                                    Text("Voice")
                                    Spacer()
                                    Image(systemName: "phone")
                                }
                            }
                        }label: {
                            HStack{
                                Image(systemName: callType == "Video" ? "video.fill" : "phone.fill")
                                    .foregroundStyle(Color(.green))
                                    .frame(width: 30, height: 30)
                                    .aspectRatio(contentMode: .fit)
                                    .background(Color(.label))
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                            
                            Text("Call type")
                                .foregroundStyle(Color(.label))
                            
                            Spacer()
                            
                            Text(callType)
                                .foregroundStyle(Color(.systemGray2))
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundStyle(Color(.systemGray2))
                        }
                    }
                }
                
                Section{
                    Button{
                        print("Send link via WhatsApp")
                    }label: {
                        HStack{
                            Text("Send link via WhatsApp")
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    
                    Button{
                        print("Copy link")
                    }label: {
                        HStack{
                            Text("Copy link")
                            Spacer()
                            Image(systemName: "paperclip")
                        }
                    }
                    
                    Button{
                        print("Share link")
                    }label: {
                        HStack{
                            Text("Share link")
                            Spacer()
                            Image(systemName: "link")
                        }
                    }
                    
                    Button{
                        print("Add to calendar")
                    }label: {
                        HStack{
                            Text("Add to calendar")
                            Spacer()
                            Image(systemName: "calendar.badge.plus")
                        }
                    }
                }
                .foregroundStyle(Color(.label))
            }
            .padding(.top, -40)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        createLinkSheet = false
                    }label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color(.label))
                    }
                }
                
                ToolbarItem(placement: .principal){
                    Text("Create call link")
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    WhatsappCallsCreateLink(createLinkSheet: .constant(true), callType: .constant("Video"))
}

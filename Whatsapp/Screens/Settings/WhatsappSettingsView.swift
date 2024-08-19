//
//  WhatsappSettingsView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import Foundation
import SwiftUI

struct WhatsappSettingsView: View {
    @Environment(WhatsappMainViewModel.self) private var mainViewModel
    @State private var searchableString = ""
    @State private var viewModel = WhatsappSettingViewModel()
    var body: some View {
        NavigationStack{
            List{
                Section{
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                        VStack(alignment: .leading){
                            Text("\(mainViewModel.currentLoggedInUser.username)")
                            Text("Status")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray))
                        }
                        
                        Spacer()
                        
                        Image(systemName: "qrcode")
                    }
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "person.crop.square")
                            Text("Avatar")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                        .foregroundStyle(Color(.label))
                    })
                }
                
                Section{
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "heart")
                            Text("Favorites")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "megaphone")
                            Text("Boradcast lists")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "star")
                            Text("Starred messages")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "macbook")
                            Text("Linked devices")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                }
                .foregroundStyle(Color(.label))
                
                Section{
                    NavigationLink(destination: {
                        WhatsappSettingAccountView(viewModel: $viewModel)
                    }, label: {
                        Button(action: {}, label: {
                            HStack{
                                Image(systemName: "key")
                                Text("Account")
                                
                                Spacer()
                            }
                        })
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "lock")
                            Text("Privacy")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "message")
                            Text("Chats")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "app.badge")
                            Text("Notifications")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "arrow.up.arrow.down")
                            Text("Storage and data")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                }
                .foregroundStyle(Color(.label))
                
                Section{
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "info.circle")
                            Text("Help")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "person.2")
                            Text("Tell a friend")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                }
                .foregroundStyle(Color(.label))
                
                Section(content: {
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "camera.on.rectangle")
                            Text("Open Instagram")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "book.pages")
                            Text("Facebook")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    })
                }, header: {
                    Text("Also from Meta")
                        .textCase(.none)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemGray))
                })
                .foregroundStyle(Color(.label))
            }
            .searchable(text: $viewModel.searchableString)
            .navigationTitle(Text("Settings"))
        }
    }
}

#Preview{
    WhatsappSettingsView()
}

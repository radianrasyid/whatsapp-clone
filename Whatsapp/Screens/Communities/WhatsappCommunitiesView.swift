//
//  WhatsappCommunitiesView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 08/07/24.
//

import Foundation
import SwiftUI

struct WhatsappCommunitiesView: View {
    var body: some View {
        NavigationStack{
            List{
                Section{
                    Button{
                        print("create community")
                    }label: {
                        HStack{
                            Image(systemName: "person.3")
                            Text("New community")
                            
                            Spacer()
                        }
                    }
                }
                
                ForEach(CommunitiesMockData.communities, id: \.id){ community in
                    Section{
                        Button{
                            print(community.name)
                        }label: {
                            HStack{
                                Image(systemName: "star")
                                Text("[KhususMahasiswa] - Program Studi TEKNIK INFORMATIKA REG1/2 - UMB")
                                    .font(.body)
                                    .lineLimit(2)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                        
                        ForEach(Array(community.subgroups.enumerated()), id: \.element.id){ index, group in
                            Button{
                                print(group.name)
                            }label: {
                                HStack{
                                    Image(systemName: "star")
                                    VStack(alignment: .leading){
                                        Text("\(group.name)")
                                            .fontWeight(.semibold)
                                        Text("~ Agung Prawoto: Testing 1 2 3 4 5 6 7 8 9 1 0")
                                            .lineLimit(1)
                                            .multilineTextAlignment(.leading)
                                            .font(.subheadline)
                                            .foregroundStyle(Color(.systemGray))
                                    }
                                    Spacer()
                                    Image(systemName: "circle")
                                }
                            }
                        }
                        
                        NavigationLink(destination: {
                            WhatsappCommunitiesDetailView(community: community)
                        }, label: {
                            HStack{
                                Text("See all")
                                    .foregroundStyle(Color(.systemGray))
                                
                                Spacer()
                            }
                        })
                    }
                    .foregroundStyle(Color(.label))
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .navigationTitle("Communities")
        }
    }
}

#Preview {
    WhatsappCommunitiesView()
}

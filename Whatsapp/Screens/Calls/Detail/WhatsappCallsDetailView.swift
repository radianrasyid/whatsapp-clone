//
//  WhatsappCallsDetailView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let details: String?
}

struct WhatsappCallsDetailView: View {
    
    @Binding var isShowingDetail: Bool
    @State private var viewModel = WhatsappCallsDetailViewModel()
    
    let alphabet = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                VStack(){
                    WhatsappContactViewTopPart(userName: "John Doe", phoneNumber: "+62888-8888-8888")
                    
                    GeometryReader { geometry in
                        HStack(spacing: 10) {
                            ForEach(["message", "phone", "video"], id: \.self) { imageName in
                                Button{
                                    print(imageName)
                                }label: {
                                    VStack(spacing: 10) {
                                        Image(systemName: imageName)
                                            .foregroundStyle(Color(.accent))
                                        Text(imageName.capitalized)
                                            .layoutPriority(1)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .frame(width: geometry.size.width)
                    }
                    .padding(.bottom)
                    .frame(height: 80) // Adjust this value as needed
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("Hai, saya menggunakan whatsapp")
                            Text("11.59")
                                .font(.footnote)
                                .foregroundStyle(Color(.systemGray))
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 10))
                    
                    VStack(alignment: .leading){
                        Text("Today")
                        HStack(alignment: .top){
                            Text("13.23")
                                .foregroundStyle(Color(.systemGray))
                            
                            Spacer()
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Image(systemName: "phone.fill")
                                    Text("Incoming voice call")
                                }
                                Text("15 minutes, 53 seconds (5,6 MB)")
                                    .foregroundStyle(Color(.systemGray))
                            }
                            .padding(.horizontal)
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 10))
                    
                    WhatsappContactDetailsListComp(lockChat: $viewModel.lockChat, photosAmount: 180, starredMessages: 0)
                    
                    HStack{
                        Text("Groups in common")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack(alignment: .leading){
                        Button{
                            viewModel.showCreateGroup = true
                        }label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Create group with john")
                                Spacer()
                            }
                        }
                        
                        Divider()
                        
                        HStack{
                            Image(systemName: "person.3.fill")
                            VStack(alignment: .leading){
                                Text("Group 1")
                                Text("john doe, jane dee, gary longbottom, jonah hex, larry mcClain")
                                    .foregroundStyle(Color(.systemGray))
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                            
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 10))
                    
                    VStack(alignment: .leading){
                        Button{
                            print("share contact")
                        }label: {
                            Text("Share contact")
                        }
                        Divider()
                        Button{
                            print("export chat")
                        }label: {
                            Text("Export chat")
                        }
                        Divider()
                        Button{
                            print("Clear chat")
                        }label: {
                            Text("Clear chat")
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                    .foregroundStyle(Color(.systemGreen))
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 10))
                    
                    VStack(alignment: .leading){
                        Button{
                            print("block john")
                        }label: {
                            Text("Block John")
                        }
                        Divider()
                        Button{
                            print("report john")
                        }label: {
                            Text("Report John")
                        }
                    }
                    .foregroundStyle(Color(.systemRed))
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding(.top, 0)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Contact info")
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        print("edit")
                    }label: {
                        Text("Edit")
                    }
                }
            }
            .foregroundStyle(Color(.label))
            .padding(.horizontal)
            .sheet(isPresented: $viewModel.showCreateGroup, onDismiss: {}){
                HStack{
                    Image(systemName: "chevron.left")
                        .onTapGesture {
                            viewModel.showCreateGroup = false
                        }
                    
                    Spacer()
                    
                    VStack{
                        Text("Add members")
                            .fontWeight(.semibold)
                        Text("0/100")
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    Text("Next")
                        .fontWeight(.semibold)
                }
                .padding()
                
                WhatsappSearchField(searchValue: $viewModel.searchText)
                
                ZStack {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(Array(viewModel.contacts.keys.sorted()), id: \.self) { key in
                                Section(header: Text(key).id(key)) {
                                    ForEach(viewModel.contacts[key] ?? []) { contact in
                                        ContactRow(contact: contact)
                                    }
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .overlay(
                            AlphabetIndex(alphabet: alphabet) { letter in
                                if let index = viewModel.contacts.keys.sorted().firstIndex(where: { $0.hasPrefix(letter) }) {
                                    withAnimation {
                                        proxy.scrollTo(viewModel.contacts.keys.sorted()[index], anchor: .top)
                                    }
                                }
                            }
                            , alignment: .trailing
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    WhatsappCallsDetailView(isShowingDetail: .constant(true))
}

struct AlphabetIndex: View {
    let alphabet: [String]
    let action: (String) -> Void
    
    var body: some View {
        VStack {
            ForEach(alphabet, id: \.self) { letter in
                Text(letter)
                    .font(.system(size: 12))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        action(letter)
                    }
            }
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(contact.name)
                if let details = contact.details {
                    Text(details)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "circle")
        }
    }
}

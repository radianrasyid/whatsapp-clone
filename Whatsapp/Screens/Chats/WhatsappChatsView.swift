//
//  WhatsappChatsView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import Foundation
import SwiftUI
import SwiftData

struct WhatsappChatsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: WhatsappChatsContextViewModel
    @State private var isShowingV2 = false
    
    var body: some View {
        NavigationStack{
            List{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Button(action: {
                            withAnimation(.bouncy){
                                viewModel.selectedType = "all"
                            }
                        }, label: {
                            Text("All")
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundStyle(viewModel.selectedType == "all" ? Color(.accent) : Color(.label))
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 10))
                        
                        Button(action: {
                            withAnimation(.bouncy){
                                viewModel.selectedType = "unread"
                            }
                        }, label: {
                            Text("Unread")
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundStyle(viewModel.selectedType == "unread" ? Color(.accent) : Color(.label))
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 10))
                        
                        Button(action: {
                            withAnimation(.bouncy){
                                viewModel.selectedType = "favorites"
                            }
                        }, label: {
                            Text("Favorites")
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundStyle(viewModel.selectedType == "favorites" ? Color(.accent) : Color(.label))
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 10))
                        
                        Button(action: {
                            withAnimation(.bouncy){
                                viewModel.selectedType = "groups"
                            }
                        }, label: {
                            Text("Groups")
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundStyle(viewModel.selectedType == "groups" ? Color(.accent) : Color(.label))
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    
                    .fontWeight(.semibold)
                }
                .listRowBackground(Color(.clear))
                .listRowSeparator(.hidden)
                //                .listRowInsets(EdgeInsets())
                
                Button(action: {
                    viewModel.isShowingArchivedChats.toggle()
                }, label: {
                    HStack{
                        Image(systemName: "archivebox")
                        Text("Archived")
                    }
                })
                
                ForEach(viewModel.chats.sorted(by: {
                    (chat1, chat2) -> Bool in
                    if chat1.pinned && !chat2.pinned{
                        return true
                    }else if !chat1.pinned && chat2.pinned{
                        return false
                    }else{
                        return false
                    }
                }), id: \.id){
                    item in
                    NavigationLink(destination: {
                        WhatsappRoomChatView(data: item)
                    }, label: {
                        WhatsappChatItemComp(data: item)
                            .whatsappLeadingSwipeActions(item: item, viewModel: $viewModel)
                            .whatsappTrailingSwipeActions(item: item, viewModel: $viewModel)
                    })
                }
            }
            .refreshable {
                viewModel.initiateData()
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Menu(content: {
                        Button(action: {
                            viewModel.addSample()
                        }, label: {
                            HStack{
                                Text("Select chats")
                                Spacer()
                                Image(systemName: "checkmark.circle")
                            }
                        })
                    }, label: {
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.label))
                        })
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    HStack{
                        Button(action: {
                            viewModel.showingCamera = true
                        }, label: {
                            Image(systemName: "camera")
                                .foregroundStyle(Color(.label))
                        })
                        
                        Button(action: {
                            viewModel.isCreateChatSheetShowed.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundStyle(Color(.darkGray))
                                .frame(width: 30, height: 30, alignment: .center)
                                .background(Color(.systemGreen))
                                .clipShape(.circle)
                        })
                    }
                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Chats")
            .navigationDestination(isPresented: $viewModel.isShowingArchivedChats){
                WhatsappArchivedChatsView(viewModel: $viewModel)
            }
            .sheet(isPresented: $viewModel.isMoreSheetShowed, content: {
                WhatsappChatMoreView(viewModel: $viewModel)
                .foregroundStyle(Color(.label))
                .padding(.top, -20)
                .presentationDetents([
                    .fraction(0.6),
                    .large
                ])
                .presentationDragIndicator(.hidden)
            })
            .sheet(isPresented: $viewModel.isCreateChatSheetShowed){
                WhatsappCreateChatSheetView(viewModel: $viewModel)
            }
            .fullScreenCover(isPresented: $viewModel.showingCamera) {
                HStack{
                    Spacer()
                    Text("Capture photo")
                    Spacer()
                    Button(action: {
                        viewModel.showingCamera = false
                    }, label:{
                        Image(systemName: "xmark")
                    })
                }
                WhatsappCustomCameraView(image: $viewModel.image, isPresented: $viewModel.showingCamera)
                    .onAppear{
                        viewModel.recentMedia = viewModel.fetchRecentMediaItems()
                    }
            }
            .searchable(text: $viewModel.searchText)
        }
    }
    
    init(modelContext: ModelContext){
        let viewModel = WhatsappChatsContextViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

struct WhatsappCreateChatSheetView: View {
    @Binding var viewModel: WhatsappChatsContextViewModel
    var body: some View {
        HStack{
            Image(systemName: "chevron.left")
                .onTapGesture {
                    viewModel.isCreateChatSheetShowed = false
                }
            
            Spacer()
            
            VStack{
                Text("Create Chat")
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Text("Next")
                .fontWeight(.semibold)
        }
        .padding()
        
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
                    AlphabetIndex(alphabet: viewModel.alphabet) { letter in
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

struct WhatsappLeadingSwipeActionsModifier: ViewModifier {
    let item: WhatsappChatsStorage
    @Binding var viewModel: WhatsappChatsContextViewModel

    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button(action: {
                    viewModel.toggleRead(for: item)
                }, label: {
                    VStack {
                        Image(systemName: item.totalUnreadedChat > 0 ? "message.fill" : "message.badge.fill")
                        Text(item.totalUnreadedChat > 0 ? "Read" : "Unread")
                    }
                    .tint(Color(.systemGreen))
                    .foregroundStyle(Color(.red))
                })
                Button(action: {
                    withAnimation(.easeInOut){
                        viewModel.togglePinned(for: item)
                    }
                }, label: {
                    VStack {
                        Image(systemName: item.pinned ? "pin.slash.fill" : "pin.fill")
                            .rotationEffect(.degrees(45))
                        Text(item.pinned ? "Unpin" : "Pin")
                    }
                    .rotationEffect(.degrees(45))
                    .tint(Color(.systemGray6))
                    .foregroundStyle(Color(.red))
                })
            }
    }
}

struct WhatsappTrailingSwipeActionsModifier: ViewModifier {
    let item: WhatsappChatsStorage
    @Binding var viewModel: WhatsappChatsContextViewModel

    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(action: {
                    withAnimation(.easeOut(duration: 0.2)){
                        viewModel.moveToArchive(for: item)
                    }
                }, label: {
                    VStack {
                        Image(systemName: "archivebox.fill")
                        Text("Unread")
                    }
                    .tint(Color(.systemGreen))
                    .foregroundStyle(Color(.red))
                })
                Button(action: {
                    viewModel.sheetData = .regular(item)
                }, label: {
                    VStack {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(45))
                        Text("More")
                    }
                    .rotationEffect(.degrees(45))
                    .tint(Color(.systemGray6))
                    .foregroundStyle(Color(.red))
                })
            }
    }
}

struct WhatsappChatMoreView: View {
    @Binding var viewModel: WhatsappChatsContextViewModel
    var body: some View {
        List{
            HStack{
                Image(systemName: "person.fill")
                if let sheetData = viewModel.sheetData {
                    switch sheetData {
                    case .regular(let whatsappChatsStorage):
                        Text(whatsappChatsStorage.username)
                    case .archived(let whatsappArchivedChatsStorage):
                        Text(whatsappArchivedChatsStorage.username)
                    }
                }
                Spacer()
                
                Button(action: {
                    viewModel.isMoreSheetShowed = false
                }, label: {
                    Image(systemName: "xmark")
                })
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color(.clear))
            
            Section{
                Button(action: {}, label: {
                    HStack{
                        Text("Mute")
                        Spacer()
                        Image(systemName: "bell.slash")
                    }
                })
                Button(action: {}, label: {
                    HStack{
                        Text("Contact info")
                        Spacer()
                        Image(systemName: "info.circle")
                    }
                })
                Button(action: {}, label: {
                    HStack{
                        Text("Lock chat")
                        Spacer()
                        Image(systemName: "lock")
                    }
                })
                Button(action: {}, label: {
                    HStack{
                        Text("Clear chat")
                        Spacer()
                        Image(systemName: "xmark.circle")
                    }
                })
                Button(action: {}, label: {
                    HStack{
                        Text("Add to Favorites")
                        Spacer()
                        Image(systemName: "heart")
                    }
                })
            }
            
            Section{
                Button(action: {}, label: {
                    HStack{
                        if let sheetData = viewModel.sheetData {
                            switch sheetData {
                            case .regular(let whatsappChatsStorage):
                                Text("Block \(whatsappChatsStorage.username)")
                            case .archived(let whatsappArchivedChatsStorage):
                                Text("Block \(whatsappArchivedChatsStorage.username)")
                            }
                        }
                        Spacer()
                        Image(systemName: "hand.raised")
                    }
                    .foregroundStyle(Color(.systemRed))
                })
                Button(action: {}, label: {
                    HStack{
                        Text("Delete chat")
                        Spacer()
                        Image(systemName: "trash")
                    }
                    .foregroundStyle(Color(.systemRed))
                })
            }
        }
    }
}

extension View {
    func whatsappLeadingSwipeActions(item: WhatsappChatsStorage, viewModel: Binding<WhatsappChatsContextViewModel>) -> some View {
        self.modifier(WhatsappLeadingSwipeActionsModifier(item: item, viewModel: viewModel))
    }

    func whatsappTrailingSwipeActions(item: WhatsappChatsStorage, viewModel: Binding<WhatsappChatsContextViewModel>) -> some View {
        self.modifier(WhatsappTrailingSwipeActionsModifier(item: item, viewModel: viewModel))
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: WhatsappChatsStorage.self, WhatsappArchivedChatsStorage.self, configurations: config)
        
        // Add some sample data
        let sampleChat = WhatsappChatsStorage(username: "John Doe", latestActivityTime: "10:30 AM", latestChatBubble: "Hello!", pinned: false, totalUnreadedChat: 2)
        container.mainContext.insert(sampleChat)
        
        return WhatsappChatsView(modelContext: container.mainContext)
    } catch {
        fatalError("Failed to create model container: \(error.localizedDescription)")
    }
}

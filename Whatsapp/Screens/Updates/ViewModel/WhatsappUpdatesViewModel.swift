//
//  WhatsappUpdatesViewModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import SwiftUI

@Observable class WhatsappUpdatesViewModel {
    var searchValue: String = ""
    var viewUpdatesExpanded: Bool = false
    var followedChannelCount: Int = 2
    var findChannelsToFollowExpanded: Bool = true
    var navigateToFindChannels: Bool = false
    var isViewUpdatesExpanded: Bool = false
    var searchableString: String = ""
    var friendsUpdates: [WhatsappUpdatesItemModel] = [
        WhatsappUpdatesItemModel(name: "John Doe", updatedAt: "24h ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Jane Smith", updatedAt: "5m ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Alice Brown", updatedAt: "1m ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Bob Johnson", updatedAt: "12h ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Charlie Davis", updatedAt: "23h ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Dana Lee", updatedAt: "3h ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Ethan Wilson", updatedAt: "15m ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Fiona White", updatedAt: "45m ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "George Hall", updatedAt: "1h ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Hannah Moore", updatedAt: "30m ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Ian Scott", updatedAt: "6h ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Jessica Allen", updatedAt: "1d ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Kevin Harris", updatedAt: "9h ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Laura Walker", updatedAt: "20m ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Michael Young", updatedAt: "8h ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Natalie King", updatedAt: "18m ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Oliver Turner", updatedAt: "2m ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Paula Perez", updatedAt: "4h ago", image: "person.circle.fill", viewed: true),
        WhatsappUpdatesItemModel(name: "Quincy Adams", updatedAt: "7h ago", image: "person.circle.fill", viewed: false),
        WhatsappUpdatesItemModel(name: "Rachel Clark", updatedAt: "11h ago", image: "person.circle.fill", viewed: true)
    ]
    
    var isUpdatesEmpty: some View {
        Section(content: {
            if(isViewUpdatesExpanded){
                if(friendsUpdates.filter{
                    $0.viewed
                }.count == 0){
                    Text("No updates has been viewed")
                }
                
                ForEach(friendsUpdates, id: \.id){
                    item in
                    if(item.viewed){
                        WhatsappContactList(contactName: item.name, updatedAt: item.updatedAt, image: item.image)
                            .onTapGesture{
                                withAnimation(.interactiveSpring(duration: 0.3)){
                                    self.toggleViewed(for: item)
                                }
                            }
                    }
                }
            }
        }, header: {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)){
                    self.isViewUpdatesExpanded.toggle()
                }
            }, label: {
                HStack{
                    Text("View updates")
                    Spacer()
                    Image(systemName:  "chevron.down")
                        .rotationEffect(.degrees(isViewUpdatesExpanded ? 0 : 180))
                        .animation(.easeInOut(duration: 0.3), value: isViewUpdatesExpanded)
                }
                .font(.caption)
                .foregroundStyle(.white)
            })
        })
    }
    
    func toggleViewed(for item: WhatsappUpdatesItemModel){
        if let index = friendsUpdates.firstIndex(where: {$0.id == item.id}){
            friendsUpdates[index].viewed.toggle()
        }
    }
    
    //    init(searchValue: String, viewUpdatesExpaneded: Bool, followedChannelCount: Int, findChannelsToFollowExpanded: Bool, navigateToFindChannels: Bool, isViewUpdatesExpanded: Bool){
    //        self.searchValue = searchValue
    //        self.viewUpdatesExpanded = viewUpdatesExpaneded
    //        self.followedChannelCount = followedChannelCount
    //        self.findChannelsToFollowExpanded = findChannelsToFollowExpanded
    //        self.navigateToFindChannels = navigateToFindChannels
    //        self.isViewUpdatesExpanded = isViewUpdatesExpanded
    //    }
}

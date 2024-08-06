//
//  WhatsappFindChannels.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//
import Foundation
import SwiftUI

struct WhatsappFindChannels: View {
    @Binding var navigateToFindChannels: Bool
    @State private var viewModel = WhatsappFindChannelsViewModel()
    
    var body: some View {
        NavigationStack {
            List{
                ScrollView(.horizontal){
                    LazyHStack(spacing: 10){
                        ForEach(0..<3, id: \.self){ item in
                            Button(action: {}, label: {
                                Text("Test")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 5)
                                    .font(.subheadline)
                                    .foregroundStyle(Color(.label))
                                    .background(Color(.secondaryLabel))
                                    .clipShape(.rect(cornerRadius: 10))
                            })
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    .listRowBackground(Color(.clear))
                    .listRowSeparator(.hidden)
                }
                Section{
                    ForEach(0..<100, id: \.self) { item in
                        WhatsappUnfollowedChannelList(channelName: "F1", followerCount: 1.6)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $viewModel.searchValue)
            .navigationTitle("Find channels")
        }
    }
}
    
    struct CustomBlurView: ShapeStyle {
        var body: some View {
            VisualEffectBlur(blurStyle: .systemMaterial)
                .frame(height: 70) // Match the height of the toolbar item
                .edgesIgnoringSafeArea(.top)
        }
    }
    
    struct ContentOffsetKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }
    
    struct VisualEffectBlur: UIViewRepresentable {
        var blurStyle: UIBlurEffect.Style
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        }
        
        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
    }
    
    #Preview {
        WhatsappFindChannels(navigateToFindChannels: .constant(true))
    }

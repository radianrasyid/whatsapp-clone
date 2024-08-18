//
//  WhatsappAuthTextfield.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 17/08/24.
//

import SwiftUI

struct WhatsappEmailTextfield: View {
    @Binding var emailTextValue: String
    var body: some View {
        HStack{
            Image(systemName: "envelope")
                .frame(width: 30)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            TextField("email", text: $emailTextValue)
                .foregroundStyle(Color(.white))
                .tint(.white)
        }
        .tint(Color(.label))
        .padding()
        .background(Color(.white).opacity(0.2))
        .clipShape(.rect(cornerRadius: 16))
    }
}

struct WhatsappPasswordTextfield: View {
    @Binding var passwordTextValue: String
    @State private var isShowingPassword: Bool = true
    var body: some View {
        HStack{
            Button(action: {
                withAnimation{
                    isShowingPassword.toggle()
                }
            }, label: {
                Image(systemName: isShowingPassword ? "lock" : "lock.open")
                        .frame(width: 30)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
            })
            .contentTransition(.symbolEffect(.replace.downUp.wholeSymbol))
            
            if(isShowingPassword){
                SecureField("password", text: $passwordTextValue)
                    .foregroundStyle(Color(.white))
                    .tint(.white)
            }else{
                TextField("password", text: $passwordTextValue)
                    .foregroundStyle(Color(.white))
                    .tint(.white)
            }
        }
        .tint(.white)
        .padding()
        .background(Color(.white).opacity(0.2))
        .clipShape(.rect(cornerRadius: 16))
    }
}

struct WhatsappUsernameTextField: View {
    @Binding var usernameTextValue: String
    var body: some View {
        HStack{
            Image(systemName: "at")
                .frame(width: 30)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            TextField("username", text: $usernameTextValue)
                .foregroundStyle(Color(.white))
                .tint(.white)
        }
        .tint(Color(.label))
        .padding()
        .background(Color(.white).opacity(0.2))
        .clipShape(.rect(cornerRadius: 16))
    }
}

struct WhatsappAuthButton: View {
    var buttonPlaceholder = "Button"
    var iconName = "arrow.forward"
    var onTap: () -> Void
    @Environment(\.isEnabled) private var isEnabled
    
    private var backgroundColor: Color {
        return isEnabled ? Color.white : Color.white.opacity(0.2)
    }
    
    private var textColor: Color {
        return isEnabled ? Color(.systemGreen) : Color.gray
    }
    
    var body: some View {
        Button(action: onTap, label: {
            HStack{
                Image(systemName: iconName)
                Text(buttonPlaceholder)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 16))
        })
    }
}

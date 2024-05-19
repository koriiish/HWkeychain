//
//  LoginView.swift
//  HWlesson33-2
//
//  Created by Карина Дьячина on 19.05.24.
//

import SwiftUI

struct LoginView: View {
    @Bindable var viewModel: LoginViewModel
    
    @State private var status = ""
    
//    @State private var username = ""
//    @State private var password = ""
//    
//    private var isLoginButtonDisabled: Bool {
//        username.isEmpty || password.isEmpty
//    }
    
    var body: some View {
        VStack {
            Text("Welcome to account!")
                .font(.title)
                .bold()
                .padding(.top, 40)
            
            VStack(spacing: 15) {
                TextField("Username", text: $viewModel.user.name)
                    .padding()
                    .frame(width: 300)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                SecureField("Password", text: $viewModel.user.password)
                    .padding()
                    .frame(width: 300)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
            ButtonView(isDisabled: viewModel.isLogginButtonDisabled, action: {
                viewModel.logIn()
            })
            Button("Sign up") {
                do {
                    status = try KeychainManager.save(
                        name: viewModel.user.name,
                        password: viewModel.user.password.data(using: .utf8) ?? Data())
                } catch {
                    print(error)
                }
            }
            Button("Click here if you forgot your password") {
                do {
                    let data = try KeychainManager.getPassword(for: viewModel.user.name)
                    status = String(decoding: data ?? Data(), as: UTF8.self)
                } catch {
                    print(error)
                }
            }
            Text(status)
                .foregroundColor(.red)
        }
        Spacer()
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}

struct ButtonView: View {
    
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Sing in")
                .bold()
                .font(.title3)
        }
        .frame(width: 300, height: 60)
        .background(LinearGradient(
            colors: isDisabled
            ? [.gray.opacity(0.5)]
            : [.white, .blue.opacity(0.4)],
            startPoint: .bottomLeading,
            endPoint: .topTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .disabled(isDisabled)
    }
}

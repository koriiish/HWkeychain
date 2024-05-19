//
//  ContentView.swift
//  HWlesson33
//
//  Created by Карина Дьячина on 19.05.24.
//

import SwiftUI

struct ContentView: View {
    @State private var account = ""
    @State private var password = ""
    @State private var status = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Input your login", text: $account)
                    .textFieldStyle(.roundedBorder)
                TextField("Input your password", text: $password)
                    .textFieldStyle(.roundedBorder)
                Button("Sign up") {
                    do {
                        status = try KeychainManager.save(
                            account: account,
                            password: password.data(using: .utf8) ?? Data())
                    } catch {
                        print(error)
                    }
                }
                
                Button("Click here if you forgot your password") {
                    do {
                        let data = try KeychainManager.getPassword(for: account)
                        status = String(decoding: data ?? Data(), as: UTF8.self)
                    } catch {
                        print(error)
                    }
                }
                Text(status)
                    .foregroundColor(.red)
                Spacer()
            }
            .padding()
            .navigationTitle("Sing up to account")
        }
    }
}

#Preview {
    ContentView()
}

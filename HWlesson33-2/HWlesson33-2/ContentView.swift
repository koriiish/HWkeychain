//
//  ContentView.swift
//  HWlesson33-2
//
//  Created by Карина Дьячина on 19.05.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = LoginViewModel()
    var body: some View {
        if !viewModel.authenticated {
            LoginView(viewModel: viewModel)
        } else {
            VStack {
                Text("Hello, \(viewModel.user.name) !")
                    .font(.title)
                Button("Log Out") {
                    viewModel.logOut()
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ContentView()
}

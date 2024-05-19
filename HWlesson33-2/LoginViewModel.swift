//
//  LoginViewModel.swift
//  HWlesson33-2
//
//  Created by Карина Дьячина on 19.05.24.
//

import Foundation
import Observation

@Observable
final class LoginViewModel {
    var user = User()
    var authenticated = false
    
//    private var sampleUsername = "Username"
//    private var samplePassword = "Password"
    
    var isLogginButtonDisabled: Bool {
        user.name.isEmpty || user.password.isEmpty
    }
    
    func logIn() {
//        guard user.name == sampleUsername, user.password == samplePassword else {
//            return
//        }
        authenticated.toggle()
    }
    
    func logOut() {
        user.name = ""
        user.password = ""
        
        authenticated.toggle()
    }
}

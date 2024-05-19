//
//  LoginViewModel.swift
//  HWlesson33-2
//
//  Created by Карина Дьячина on 19.05.24.
//

import Foundation
import Observation
import SwiftyKeychainKit
import UserNotifications

@Observable
final class LoginViewModel {
    var user = User()
    var authenticated = false
    private let authService: AuthService = SwiftyKeychainKitAuthService.shared
    
    private var notificationCenter = UNUserNotificationCenter.current()
    private let identifier = "loginNotification"
    let dayTimeInterval: TimeInterval = 86400 // 24 hours in seconds 86400
    
//    private var sampleUsername = "Username"
//    private var samplePassword = "Password"
    
    var isLogginButtonDisabled: Bool {
        user.name.isEmpty || user.password.isEmpty
    }
    
    func logIn() {
        //guard user.name == sampleUsername, user.password == samplePassword else {
        //return
  //}
        let authKey = UUID().uuidString
        
        authService.set(user.name, for: KeychainKeys.username)
        authService.set(user.password, for: KeychainKeys.password)
        authService.set(authKey, for: KeychainKeys.authToken)
        
        addNotification()
        
        authenticated.toggle()
    }
    
    func getUsername() -> String {
        return authService.getValue(for: KeychainKeys.username) ?? "Error: username not found"
    }
    
    func logOut() {
        user.name = ""
        user.password = ""
        
        authenticated.toggle()
        
        authService.clean()
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        
//        let date = Calendar.current.startOfDay(for: Date())
//        let tomorrow = date + dayTimeInterval
        content.title = "Attention⚠️"
        content.subtitle = "You need to reLogIn"
        content.sound = UNNotificationSound.defaultCritical
        
      //  let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: tomorrow)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: dayTimeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request)
    }
}

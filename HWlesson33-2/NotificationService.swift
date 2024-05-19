//
//  NotificationService.swift
//  HWlesson33-2
//
//  Created by Карина Дьячина on 19.05.24.
//

//import Foundation
//import UserNotifications
//
//class UINotificationCenterService {
//    
//    static let shared = UINotificationCenterService()
//    
//    private var notificationCenter = UNUserNotificationCenter.current()
//    private let identifier = "loginNotification"
//    
//    let dayTimeInterval: TimeInterval = 10 // 24 hours in seconds 86400
//    
//    private init() {}
//    
//    func checkCondition(successCompletion: @escaping (() -> Void)) {
//            notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                if success {
//                    successCompletion()
//                } else if let error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//
//        func addNotification() {
//            let content = UNMutableNotificationContent()
//            content.title = "Attention⚠️"
//            content.subtitle = "You need to reLogIn"
//            content.sound = UNNotificationSound.defaultCritical
//            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: dayTimeInterval, repeats: false)
//            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//
//            notificationCenter.add(request)
//        }
//        
//        func removePreviousNotifications() {
//            notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
//        }
//}

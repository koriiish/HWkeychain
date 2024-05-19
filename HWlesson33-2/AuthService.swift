//
//  AuthService.swift
//  HWlesson33-2
//
//  Created by Карина Дьячина on 19.05.24.
//

import Foundation
import SwiftyKeychainKit

protocol AuthService {
    func set(_ value: String, for key: String)
    func update(_ value: String, for key: String)
    func getValue(for key: String) -> String?
    func removeValue(for key: String)
    func clean()
}

class SwiftyKeychainKitAuthService: AuthService {
    
    static let shared = SwiftyKeychainKitAuthService()
    
    let keychain = Keychain()
    let service = "com.example.karrie's_auth"
        
    let queue = DispatchQueue(label: "keychain")
    
    
    func set(_ value: String, for key: String) {
        queue.sync {
            do {
                let accessTokenKey = KeychainKey<String>.genericPassword(key: key, service: service)
                try keychain.set(value, for: accessTokenKey)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func update(_ value: String, for key: String) {
        queue.sync {
            do {
                let accessTokenKey = KeychainKey<String>.genericPassword(key: key, service: service)
                try keychain.set(value, for: accessTokenKey)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getValue(for key: String) -> String? {
        var value: String? = nil
        queue.sync {
            do {
                let accessTokenKey = KeychainKey<String>.genericPassword(key: key, service: service)
                value = try keychain.get(accessTokenKey)
            } catch {
                print(error.localizedDescription)
            }
        }
        return value
    }
    
    func removeValue(for key: String) {
        queue.sync {
            do {
                let accessTokenKey = KeychainKey<String>.genericPassword(key: key, service: service)
                try keychain.remove(accessTokenKey)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func clean() {
        queue.sync {
            do {
                try keychain.removeAll()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

    

//
//  UserDefaultManager.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 28/05/24.
//

import Foundation

extension UserDefaults {
    
    func isUserAuthorized() -> Bool {
        return bool(forKey: "user_login")
    }
    
    func setUserAuthorized() {
        set(true, forKey: "user_login")
    }
    
    func setUserEmail(email: String) {
        set(email, forKey: "user_email")
    }
    
    func getUserEmail() -> String {
        return string(forKey: "user_email") ?? ""
    }
    
    func logOut() {
        set(false, forKey: "user_login")
    }
}

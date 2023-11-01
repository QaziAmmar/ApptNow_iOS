//
//  UserManager.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 01/08/2023.
//

import Foundation

enum UserDefaultEnum: String {
    case userName
    case userPhone
    case profileImage
}

final class UserManager {
    
    private init() {}
    static let shared = UserManager()
    
    func set(user: User) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(user)
            UserDefaults.Application.User.save(encodedData)
//            just to update into setting view.
            UserDefaults.standard.set(user.name, forKey: UserDefaultEnum.userName.rawValue)
            UserDefaults.standard.set(user.phone, forKey: UserDefaultEnum.userPhone.rawValue)
            UserDefaults.standard.set(user.image, forKey: UserDefaultEnum.profileImage.rawValue)
            
        } catch {
            debugPrint("Error encoding user:", error)
        }
    }
    
    func get() -> User? {
        if let userData = UserDefaults.Application.User.get() {
            return try? JSONDecoder().decode(User.self, from: userData)
        }
        return nil
    }
    
    func removeUser() {
        UserDefaults.Application.User.delete()
    }
    
    func updateUser(_ block: (inout User) -> Void) {
        guard var user = get() else { return }
        block(&user)
        set(user: user)
    }
    
    func updateName(_ newName: String) {
        updateUser { user in
            user.name = newName
        }
    }
    
    func updateImage(_ newImage: String) {
        updateUser { user in
            user.image = newImage
        }
    }
    
}
// MARK: Bacis Methods
extension UserManager {
    func isUserLogin() -> Bool {
        get() != nil
    }
    
    func isUserPhoneRegistered() -> Bool {
        guard let user = get() else { return false }
        return !user.phone.isEmpty
    }
}

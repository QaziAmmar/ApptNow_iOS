//
//  UserDefaults.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 01/08/2023.
//

import Foundation

protocol UserDefaultsKey {
    var rawValue: String { get }
}

extension UserDefaults {
    
    enum Application: String, UserDefaultsKey {
        case User
    }
    
    static func remove(keys: [UserDefaultsKey]) {
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
        UserDefaults.standard.synchronize()
    }
}

extension UserDefaultsKey {
    func save(_ value: String, keySuffix:String = "") {
        UserDefaults.standard.set(value, forKey: self.rawValue + keySuffix)
        UserDefaults.standard.synchronize()
    }
    
    func save(_ value: [String]) {
        UserDefaults.standard.set(value, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func save(_ value: Int) {
        UserDefaults.standard.set(value, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func save(_ value: Data, keySuffix: String = "") {
        UserDefaults.standard.set(value, forKey: self.rawValue + keySuffix)
        UserDefaults.standard.synchronize()
    }
    
    func get() -> Data? {
        return UserDefaults.standard.data(forKey: self.rawValue)
    }
    
    func get(defaultValue: String? = nil, keySuffix:String = "") -> String? {
        return UserDefaults.standard.string(forKey: self.rawValue + keySuffix) ?? defaultValue
    }
    
    func get() -> Int {
        return UserDefaults.standard.integer(forKey: self.rawValue)
    }
    
    func delete(keySuffix:String = "") {
        UserDefaults.standard.removeObject(forKey: self.rawValue + keySuffix)
        UserDefaults.standard.synchronize()
    }
    
    
    func makeTrue() {
        save("true")
    }
    
    func makeFalse() {
        save("false")
    }
    
    func isEnabled() -> Bool {
        return self.isTrue(defaultValue: false)
    }
    
    func isTrue(defaultValue: Bool = true) -> Bool {
        return self.get(defaultValue: defaultValue ? "true" : nil) == "true"
    }
    
    func isSet() -> Bool {
        return self.get() != nil
    }
    
    /// MARK: Array
    func array() -> [String] {
        return (UserDefaults.standard.array(forKey: self.rawValue) as? [String]) ?? [String]()
    }
    
    func append(_ value: String) {
        if self.isInArray(value) {
            return
        }
        
        var array = self.array()
        array.append(value)
        self.save(array)
    }
    
    func remove(_ value: String) {
        var array = self.array()
        array.remove(object: value)
        self.save(array)
    }
    
    func isInArray(_ value: String) -> Bool {
        return self.array().contains(value)
    }
}


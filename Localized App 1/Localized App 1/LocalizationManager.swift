//
//  LocalizationManager.swift
//  Localized App 1
//
//  Created by Muhammad Waleed on 08.12.23.
//

import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()
    
    private init() {}
    
    func localizedString(_ key: String, language: String) -> String {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            print("Error: Unable to find path for language '\(language)'")
            return key
        }
        
        guard let bundle = Bundle(path: path) else {
            print("Error: Unable to create bundle for path '\(path)'")
            return key
        }
        
        let localizedString = NSLocalizedString(key, tableName: "Localizable", bundle: bundle, value: key, comment: key)
        print("Localized '\(key)' in language '\(language)': \(localizedString)")
        
        return localizedString
    }
}

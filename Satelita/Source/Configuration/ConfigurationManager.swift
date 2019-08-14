//
//  ConfigurationManager.swift
//  Satelita
//
//  Created by Konrad Belzowski on 09/08/2019.
//  Copyright © 2019 Konrad Belzowski. All rights reserved.
//

import Foundation

struct ConfigurationManager {
    
    //
    // MARK: - Singleton
    //
    
    static let sharedInstance = ConfigurationManager()
    
    //
    // MARK: - Getters
    //
    
    var serverAddress: String? {
     return getProperty(name: "serverAddress", withRoot: "API")
    }
    
    //
    // MARK: - Helpers
    //
    
    private func loadConfiguration() -> [String: Any]? {
        
        let fileURL = Bundle.main.url(forResource: "config", withExtension: "plist")
        
        guard let url = fileURL else {
            return nil
        }
        
        let fileData: Data
        let dict: [String: Any]?
        
        do {
            fileData = try Data.init(contentsOf: url)
        } catch {
            print(error)
            return nil
        }
        
        do {
            dict = try PropertyListSerialization.propertyList(from: fileData, format: nil) as? [String: Any]
        } catch {
            print(error)
            return nil
        }
        
        return dict
    }
    
    private func getProperty(name: String, withRoot root: String) -> String? {
        let dict = loadConfiguration()
        
        guard let properties = dict else {
            return nil
        }
        
        guard let api = properties[root] as? [String: Any] else {
            return nil
        }
        
        guard let result = api[name] as? String else {
            return nil
        }
        
        return result
    }
}

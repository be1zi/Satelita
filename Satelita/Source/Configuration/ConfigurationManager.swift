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
    // MARK: - Init
    //
    
    init() {
        Logger.setType(ConfigurationManager.self)
    }
    
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
            Logger.logError(error: "Configuration file not found!")
            return nil
        }
        
        let fileData: Data
        let dict: [String: Any]?
        
        do {
            fileData = try Data.init(contentsOf: url)
        } catch {
            Logger.logError(error: error)
            return nil
        }
        
        do {
            dict = try PropertyListSerialization.propertyList(from: fileData, format: nil) as? [String: Any]
        } catch {
            Logger.logError(error: error)
            return nil
        }
        
        return dict
    }
    
    private func getProperty(name: String, withRoot root: String) -> String? {
        let dict = loadConfiguration()
        
        guard let properties = dict else {
            Logger.logError(error: "Cant load properties from configuration file.")
            return nil
        }
        
        guard let api = properties[root] as? [String: Any] else {
            Logger.logError(error: "Root with name \"\(root)\" doesnt exist in configuration file.")
            return nil
        }
        
        guard let result = api[name] as? String else {
            Logger.logError(error: "Cant cast properties data into dictionary.")
            return nil
        }
        
        return result
    }
}

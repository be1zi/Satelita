//
//  Logger.swift
//  Satelita
//
//  Created by Konrad Belzowski on 14/08/2019.
//  Copyright © 2019 Konrad Belzowski. All rights reserved.
//

import Foundation
import os.log

struct Logger {
    
    private static var log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "DEFAULT")
    
    static func setType(_ type: Any) {
        log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: type))
    }
    
    static func logError(error: Error) {
        os_log("%@", log: log, type: .error, error.localizedDescription)
    }
    
    static func logError(error: String) {
        os_log("%@", log: log, type: .error, error)
    }
    
    static func logInfo(info: String) {
        os_log("%@", log: log, type: .info, info)
    }
}

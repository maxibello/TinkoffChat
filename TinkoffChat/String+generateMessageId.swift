//
//  String+generateMessageId.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 04.04.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

extension String {
    
    static func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))"
            .data(using: .utf8)?.base64EncodedString()
        return string!
    }
    
}

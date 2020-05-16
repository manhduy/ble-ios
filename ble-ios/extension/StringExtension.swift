//
//  StringExtension.swift
//  ble-ios
//
//  Created by duyha on 5/16/20.
//  Copyright © 2020 Duy Ha. All rights reserved.
//

import Foundation

extension String {
        func fromBase64() -> String? {
                guard let data = Data(base64Encoded: self) else {
                        return nil
                }
                return String(data: data, encoding: .utf8)
        }
        func toBase64() -> String {
                return Data(self.utf8).base64EncodedString()
        }
}

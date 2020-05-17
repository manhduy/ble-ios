//
//  BlePeripheralDelegate.swift
//  blelib
//
//  Created by duyha on 5/17/20.
//  Copyright © 2020 Duy Ha. All rights reserved.
//

import Foundation

public protocol BlePeripheralDelegate {
    
    func advertising()
    
    func writingRed()
    
    func writingGreen()
    
    func peripheralError(error: PeripheralError)
}

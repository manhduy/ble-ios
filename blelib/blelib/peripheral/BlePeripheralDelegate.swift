//
//  BlePeripheralDelegate.swift
//  blelib
//
//  Created by duyha on 5/17/20.
//  Copyright © 2020 Duy Ha. All rights reserved.
//

import Foundation


/// The delegate object that will receive peripheral events.
public protocol BlePeripheralDelegate {
    
    /// Starts advertising.
    func advertising()
    
    /// Writing RED value to characteristic
    func writingRed()
    
    /// Writing GREEN value to characteristic
    func writingGreen()
    
    /// An error occured.
    /// @see PeripheralError.
    func peripheralError(error: PeripheralError)
}

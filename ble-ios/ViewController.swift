//
//  ViewController.swift
//  ble-ios
//
//  Created by duyha on 5/16/20.
//  Copyright © 2020 Duy Ha. All rights reserved.
//

import UIKit
import blelib

class ViewController: UIViewController, BlePeripheralDelegate {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var viewLed: UIView!
    
    private var blePeripheral: BlePeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blePeripheral = BlePeripheral(delegate: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        blePeripheral?.stopPeripheral()
    }
    
    func advertising() {
        messageLabel.text = "Advertising data"
    }
    
    func writingRed() {
        messageLabel.text = "Writing Red"
        viewLed.backgroundColor = UIColor.red
    }
    
    func writingGreen() {
        messageLabel.text = "Writing Green"
        viewLed.backgroundColor = UIColor.green
    }
    
    func peripheralError(error: PeripheralError) {
        switch error {
            case .unknown:
                messageLabel.text = "Bluetooth Device is UNKNOWN"
            case .unsupported:
                messageLabel.text = "Bluetooth Device is UNSUPPORTED"
            case .unauthorized:
                messageLabel.text = "Bluetooth Device is UNAUTHORIZED"
            case .resetting:
                messageLabel.text = "Bluetooth Device is RESETTING"
            case .poweredOff:
                messageLabel.text = "Bluetooth Device is POWERED OFF"
        }
    }
}


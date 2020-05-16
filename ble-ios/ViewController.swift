//
//  ViewController.swift
//  ble-ios
//
//  Created by duyha on 5/16/20.
//  Copyright © 2020 Duy Ha. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var viewLed: UIView!
    
    private var peripheralManager : CBPeripheralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
            case .unknown:
                print("Bluetooth Device is UNKNOWN")
            case .unsupported:
                print("Bluetooth Device is UNSUPPORTED")
            case .unauthorized:
                print("Bluetooth Device is UNAUTHORIZED")
            case .resetting:
                print("Bluetooth Device is RESETTING")
            case .poweredOff:
                print("Bluetooth Device is POWERED OFF")
            case .poweredOn:
                print("Bluetooth Device is POWERED ON")
                addServices()
            @unknown default:
                print("Unknown State")
        }
    }
    
    private var serviceUUID: CBUUID!
    private let CHAR_VAL_RED = "RED"
    private let CHAR_VAL_GREEN = "GREEN"
    private let SERVICE_UUID = "00000000-0000-0000-0000-000000000000"
    func addServices() {
         // 1. Create instance of CBMutableCharcateristic
        let myChar = CBMutableCharacteristic(type: CBUUID(nsuuid: createDefaultUUID()), properties: [.notify, .write, .read], value: nil, permissions: [.readable, .writeable])
        // 2. Create instance of CBMutableService
        serviceUUID = CBUUID(nsuuid: createDefaultUUID())
        let service = CBMutableService(type: serviceUUID, primary: true)
        // 3. Add characteristics to the service
        service.characteristics = [myChar]
        // 4. Add service to peripheralManager
        peripheralManager.add(service)
        // 5. Start advertising
        startAdvertising()
    }
    
    func createDefaultUUID() -> UUID {
        return UUID(uuidString: SERVICE_UUID) ?? UUID()
    }
    
    func startAdvertising() {
        messageLabel.text = "Advertising Data"
        peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "BLEPeripheral", CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
        print("Started Advertising")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        print("Writing Data")
        if let value = requests.first?.value {
            if (value.base64EncodedString() == CHAR_VAL_RED.toBase64()) {
                messageLabel.text = "Writing RED"
                viewLed.backgroundColor = UIColor.red
            } else if (value.base64EncodedString() == CHAR_VAL_GREEN.toBase64()) {
                messageLabel.text = "Writing GREEN"
                viewLed.backgroundColor = UIColor.green
            }
        }
    }
}


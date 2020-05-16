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
    @IBOutlet var readValueLabel: UILabel!
    @IBOutlet var writeValueLabel: UILabel!
    
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
    
    private var service: CBUUID!
    private let value = "AD34E"
    private var SERVICE_UUID = "00000000-0000-0000-0000-000000000000"
    func addServices() {
         // 1. Create instance of CBMutableCharcateristic
        let myChar = CBMutableCharacteristic(type: CBUUID(nsuuid: createDefaultUUID()), properties: [.notify, .write, .read], value: nil, permissions: [.readable, .writeable])
        // 2. Create instance of CBMutableService
        service = CBUUID(nsuuid: createDefaultUUID())
        let myService = CBMutableService(type: service, primary: true)
        // 3. Add characteristics to the service
        myService.characteristics = [myChar]
        // 4. Add service to peripheralManager
        peripheralManager.add(myService)
        // 5. Start advertising
        startAdvertising()
    }
    
    func createDefaultUUID() -> UUID {
        return UUID(uuidString: SERVICE_UUID) ?? UUID()
    }
    
    func startAdvertising() {
        messageLabel.text = "Advertising Data"
        peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "BLEPeripheralApp", CBAdvertisementDataServiceUUIDsKey :     [service]])
        print("Started Advertising")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        messageLabel.text = "Writing Data"
        if let value = requests.first?.value {
            writeValueLabel.text = value.base64EncodedString()
            //Perform here your additional operations on the data.
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        messageLabel.text = "Data getting Read"
        readValueLabel.text = value
        // Perform your additional operations here
    }


}
extension Data {
 struct HexEncodingOptions: OptionSet {
     let rawValue: Int
     static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
 }
 func hexEncodedString(options: HexEncodingOptions = []) -> String {
     let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
     return map { String(format: format, $0) }.joined()
 }
}


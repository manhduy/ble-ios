//
//  BlePeripheral.swift
//  blelib
//
//  Created by duyha on 5/17/20.
//  Copyright © 2020 Duy Ha. All rights reserved.
//

import Foundation
import CoreBluetooth


/// A wrapper class of CBPeripheralManager
public class BlePeripheral: NSObject, CBPeripheralManagerDelegate {
    
    private var peripheralDelegate: BlePeripheralDelegate?
    
    private var serviceUUID: CBUUID!
    private let CHAR_VAL_RED = "RED"
    private let CHAR_VAL_GREEN = "GREEN"
    private let SERVICE_UUID = "00000000-0000-0000-0000-000000000000"
    
    private var peripheralManager : CBPeripheralManager!
    
    
    /// Initialize BlePeripheral
    /// - Parameter delegate: The delegate object that will receive peripheral events.
    public init(delegate: BlePeripheralDelegate) {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        peripheralDelegate = delegate
    }
    
    
    /// Delete event of CBPeripheralManagerDelegate
    /// - Parameter peripheral: The peripheral manager whose state has changed.
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
            case .unknown:
                peripheralDelegate?.peripheralError(error: .unknown)
                print("Bluetooth Device is UNKNOWN")
            case .unsupported:
                peripheralDelegate?.peripheralError(error: .unsupported)
                print("Bluetooth Device is UNSUPPORTED")
            case .unauthorized:
                peripheralDelegate?.peripheralError(error: .unauthorized)
                print("Bluetooth Device is UNAUTHORIZED")
            case .resetting:
                peripheralDelegate?.peripheralError(error: .resetting)
                print("Bluetooth Device is RESETTING")
            case .poweredOff:
                peripheralDelegate?.peripheralError(error: .poweredOff)
                print("Bluetooth Device is POWERED OFF")
            case .poweredOn:
                print("Bluetooth Device is POWERED ON")
                addServices()
            @unknown default:
                peripheralDelegate?.peripheralError(error: .unknown)
                print("Unknown State")
        }
    }

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
        peripheralDelegate?.advertising()
        peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "BLEPeripheral", CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
        print("Started Advertising")
    }
    
    
    /// Delete event of CBPeripheralManagerDelegate
    /// - Parameters:
    ///   - peripheral: The peripheral manager requesting this information.
    ///   - requests: A list of one or more <code>CBATTRequest</code> objects.
    public func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        if let value = requests.first?.value {
            if (value.base64EncodedString() == CHAR_VAL_RED.toBase64()) {
                peripheralDelegate?.writingRed()
            } else if (value.base64EncodedString() == CHAR_VAL_GREEN.toBase64()) {
                peripheralDelegate?.writingGreen()
            }
        }
    }
    
    
    /// Stop advertising and release BlePeripheral object
    public func stopPeripheral() {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
    }
}

/// A list of Peripheral error type.
public enum PeripheralError : Int {

    ///Bluetooth device is unknown.
    case unknown

    ///Bluetooth device is unsupported.
    case unsupported

    ///Bluetooth device is unauthorized.
    case unauthorized
    
    ///Bluetooth device is resetting.
    case resetting

    ///Bluetooth device is off.
    case poweredOff
}

# BlePeripheral library

BlePeripheral is a wrapper library for easy establishing a BlePeripheral. 

## Getting started

### Add blelib to your workspace

At first, add blelib module to your workspace. In Project Navigator, blelib should appear.

![image info](./docs-images/add_blelib.png)

### Add blelib to your iOS app module

In Project Navigator, select your app. Then select General. Under Frameworks, Libraries, and Embedded Content click (+). Then select blelib.

![image info](./docs-images/add_lib_to_ios_app.png)

### Create BlePeripheral instance in your UIViewController

```swift

private var blePeripheral: BlePeripheral?
    
override func viewDidLoad() {
    super.viewDidLoad()
    blePeripheral = BlePeripheral(delegate: self)
}

```

You need to make your UIViewController implement BlePeripheralDelegate

```swift

class ViewController: UIViewController, BlePeripheralDelegate {
    ...

    func advertising() {
        // Your logic code
    }
    
    func writingRed() {
        // Your logic code
    }
    
    func writingGreen() {
        // Your logic code
    }
    
    func peripheralError(error: PeripheralError) {
        // Your logic code
    }

```

### Stop the BlePeripheral

Finally, you need to stop the BlePeripheral.

```swift

override func viewDidDisappear(_ animated: Bool) {
    blePeripheral?.stopPeripheral()
}

```

### [Library Document](https://manhduy.github.io/ios-blelib-docs/)
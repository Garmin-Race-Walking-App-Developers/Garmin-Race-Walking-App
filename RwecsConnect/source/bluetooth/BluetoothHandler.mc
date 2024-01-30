using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;

class BluetoothHandler extends Ble.BleDelegate {
    private static var instance = null;
    hidden var connectableDevices;
    private var connectedDevices;
    private var btCtx;
    private var btReqQueue;

    function initialize() {
        BleDelegate.initialize();
        btCtx = BluetoothContext.getInstance();
        btReqQueue = CommunicationQueue.getInstance();
        connectableDevices = {};
        connectedDevices = [];
        Ble.setDelegate(self);
    }

    static function getInstance() {
        if (instance == null) { 
            instance = new BluetoothHandler();
        }
        return instance;
    }
    
    function onScanResults(scanResults as Ble.Iterator) {
        //Handle results
        System.println("Results found");
        for( var result = scanResults.next(); result != null; result = scanResults.next() ) { 
            var deviceName = result.getDeviceName(); 
			if (matchingDeviceName(deviceName)) {
                System.println("Found RWECS device");
                if (!connectableDevices.hasKey(deviceName) && connectedDevices.indexOf(deviceName == -1)) {
                    connectableDevices.put(deviceName, result);
                }
			}
        }      
    }

    function startScan() {
        System.println("Searhing for RWECS devices");
    	Ble.setScanState(Ble.SCAN_STATE_SCANNING);
    }
    
    function stopScan() {
        System.println("No longer searhing for RWECS devices");
    	Ble.setScanState(Ble.SCAN_STATE_OFF);
    }
    
    function onScanStateChange(scanState, status) {
    	System.println(scanState);
    }

    function onCharacteristicRead(characteristic, status, value) {
        System.println(status);
        System.println(value);
        //TODO UPDATE UI

    }

    function onCharacteristicChanged(characteristic, value) {
        System.println(value);
        //TODO send value to data handler
        //TODO UPDATE UI
    }

    function onCharacteristicWrite(characteristic, status) {
        System.println("Write request returned status: " + status);
        btReqQueue.run();
    }

    function onDescriptorWrite(descriptor, status) {
        System.println("Write request returned status: " + status);
        btReqQueue.run();
    }

    function getConnectableDevices() {
        return self.connectableDevices;
    }

    function connectToDeviceByName(name) {
        if (connectableDevices.hasKey(name)) {
            var device = connectableDevices.get(name);
            Ble.pairDevice(device);
            System.println("Connection success!");
            connectedDevices.add(name);
            connectableDevices.remove(name);
        }
    }

    function allDevicesConnected() {
        var devices = Ble.getPairedDevices();
        var currentDevice = devices.next() as Ble.Device;
        while (currentDevice != null ) {
            if (!currentDevice.isConnected()) {
                return false;
            }
            currentDevice = devices.next();
        }
        return true;
    }

    function unpairDevices(){
        var devices = Ble.getPairedDevices();
        var currentDevice = devices.next() as Ble.Device;
        while (currentDevice != null ) {
            Ble.unpairDevice(currentDevice);
            currentDevice = devices.next();
        }
        connectedDevices = [];
    }

    private function matchingDeviceName(deviceName) {
        if (deviceName) {
            var index = deviceName.find("RWECS");
            if (index == 0) {
                return true;
            }
        }
        return false;
    }
}
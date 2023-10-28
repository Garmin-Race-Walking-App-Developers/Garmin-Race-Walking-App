using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;

class BluetoothHandler extends Ble.BleDelegate {
    hidden var connectableDevices;

    function initialize() {
        BleDelegate.initialize();
        connectableDevices = {};
    }
    
    function onScanResults(scanResults as Ble.Iterator) {
        //Handle results
        System.println("Results found");
        for( var result = scanResults.next(); result != null; result = scanResults.next() ) { 
            var deviceName = result.getDeviceName();   
			if (matchingDeviceName(deviceName)) {
                System.println("Found RWECS device");
                if (!connectableDevices.hasKey(deviceName)) {
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

    function getConnectableDevices() {
        return self.connectableDevices;
    }

    function connectToDeviceByName(name) {
        if (connectableDevices.hasKey(name)) {
            Ble.pairDevice(connectableDevices.get(name));
            System.println("Connection success!");
        }
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
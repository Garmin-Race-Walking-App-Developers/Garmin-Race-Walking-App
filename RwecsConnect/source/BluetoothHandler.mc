using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;

class BluetoothHandler extends Ble.BleDelegate {
    hidden var connectableDevices;
    private var CUSTOM_SERVICE = Ble.stringToUuid("D973F2E0-B19E-11E2-9E96-0800200C9A66");
    var CUSTOM_SERVICE_READ = Ble.stringToUuid("D973F2E1-B19E-11E2-9E96-0800200C9A66");
    var CUSTOM_SERVICE_CONTROL = Ble.stringToUuid("D973F2E2-B19E-11E2-9E96-0800200C9A66");
    private const START_WORKOUT = [ 'T' ]b;
    // var BATTERY_SERVICE = Ble.longToUuid(0x18, 0x0F);
    // var BATTERY_SERVICE_READ = Ble.longToUuid(0x2A, 0x19);
    // var DEVICE_INFO_SERVICE = Ble.longToUuid(0x18, 0x0A);
    // var DEVICE_INFO_SERVICE_DSN = Ble.longToUuid(0x2A, 0x25);  

    function initialize() {
        BleDelegate.initialize();
        registerProfiles();
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

    function onCharacteristicRead(characteristic, status, value) {
        System.println(status);
        System.println(value);
        //TODO UPDATE UI
    }

    function onCharacteristicWrite(characteristic, status) {
        System.println("Write request returned status: " + status);
    }

    function getConnectableDevices() {
        return self.connectableDevices;
    }

    function enableTrainingMode() {
        var devices = Ble.getPairedDevices() as Ble.Iterator;
        var currentDevice = devices.next();
        while (currentDevice != null ) {
            sendCommand(currentDevice, START_WORKOUT, Ble.WRITE_TYPE_DEFAULT);
            currentDevice = devices.next();
        }
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

    private function registerProfiles() {
        var customServiceProfile = {                                                
            :uuid => CUSTOM_SERVICE,
            :characteristics => [
                {
                    :uuid => CUSTOM_SERVICE_READ,
                    :descriptors => [Ble.cccdUuid()]
                }, 
                {
                    :uuid => CUSTOM_SERVICE_CONTROL,
                    :descriptors => [Ble.cccdUuid()]
                }
            ]
        };

    // TODO get real UUIDS to get working
    //     var batteryServiceProfile = {                                                 
    //         :uuid => BATTERY_SERVICE,
    //         :characteristics => [
    //         {                                      
    //             :uuid => BATTERY_SERVICE_READ,
    //             :descriptors => [Ble.cccdUuid()]
    //         }] 
    //    };
    //    var deviceInformationService = {
    //     :uuid => DEVICE_INFO_SERVICE,
    //     :characteristics => [
    //         {
    //             :uuid => DEVICE_INFO_SERVICE_DSN
    //         }
    //     ]};


       Ble.registerProfile( customServiceProfile );
    //    Ble.registerProfile( batteryServiceProfile );
    //    Ble.registerProfile( deviceInformationService );
    }

    private function sendCommand(device, command, writeType) {
        var service = device.getService(CUSTOM_SERVICE);
        var controller = service.getCharacteristic(CUSTOM_SERVICE_CONTROL);
        try {
            controller.requestWrite(command, { :writeType => writeType });
        } catch (e) {
            System.println(e.getErrorMessage());
        }
    }
}
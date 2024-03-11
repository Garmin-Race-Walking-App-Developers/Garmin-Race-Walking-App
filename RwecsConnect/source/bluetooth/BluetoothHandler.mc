using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;
using Toybox.Lang as Lang;
using Toybox.Attention as Attention;
using Toybox.Math as Math;
import Toybox.WatchUi;

class BluetoothHandler extends Ble.BleDelegate {
    private static var instance = null;
    hidden var connectableDevices;
    private var connectedDevices;
    private var btCtx;
    private var btReqQueue;
    private var dataParser;
    public var averageFlightTime = 0;

    function initialize() {
        BleDelegate.initialize();
        btCtx = BluetoothContext.getInstance();
        btReqQueue = CommunicationQueue.getInstance();
        dataParser = new RWECSDataParser();

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
        for( var result = scanResults.next(); result != null; result = scanResults.next() ) { 
            var deviceName = result.getDeviceName(); 
			if (matchingDeviceName(deviceName)) {
                if (!connectableDevices.hasKey(deviceName) && connectedDevices.indexOf(deviceName == -1)) {
                    connectableDevices.put(deviceName, result);
                }
			}
        }      
    }

    function startScan() {
        System.println("Searching for RWECS devices");
    	Ble.setScanState(Ble.SCAN_STATE_SCANNING);
    }
    
    function stopScan() {
        System.println("No longer searching for RWECS devices");
    	Ble.setScanState(Ble.SCAN_STATE_OFF);
    }
    
    function onScanStateChange(scanState, status) {
    	System.println(scanState);
    }

    function onCharacteristicChanged(characteristic, value as Lang.ByteArray) {
        dataParser.updateFlightTimeList(value);
        var peakFlightTime = dataParser.getPeakFlightTime();

        if (peakFlightTime > SettingsContext.getInstance().getThresholdValue()) {
            var toneProfile =
            [
                new Attention.ToneProfile(500, 250)
            ];
            Attention.playTone({:toneProfile=>toneProfile});
        }
      
        WatchUi.requestUpdate();
    }

    function onCharacteristicWrite(characteristic, status) {
        System.println("Write request returned status: " + status);
        btReqQueue.finishRun();
    }

    function onDescriptorWrite(descriptor, status) {
        System.println("Write request returned status: " + status);
        btReqQueue.finishRun();
    }

    function getConnectableDevices() {
        return self.connectableDevices;
    }

    function hasConnectedDevices() {
        return self.connectedDevices != null && self.connectedDevices.size() != 0;
    }

    function connectToDeviceByName(name) {
        if (connectableDevices.hasKey(name)) {
            var device = connectableDevices.get(name);
            Ble.pairDevice(device);
            System.println("Connecting to device: " + name);
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

    function unpairDevices() {
        var devices = Ble.getPairedDevices();
        var currentDevice = devices.next() as Ble.Device;
        while (currentDevice != null ) {
            Ble.unpairDevice(currentDevice);
            currentDevice = devices.next();
        }
        connectedDevices = [];
    }

    function undoPairing(name) {
        connectedDevices.remove(name);
        unpairFailedPairings();
    }

    private function unpairFailedPairings() {
        var devices = Ble.getPairedDevices();
        var currentDevice = devices.next() as Ble.Device;
        while (currentDevice != null ) {
            if (currentDevice.getName() == null) {
                Ble.unpairDevice(currentDevice);
            }
            currentDevice = devices.next();
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
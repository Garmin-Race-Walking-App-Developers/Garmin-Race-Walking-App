using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;

class DeviceController {
    private var btCtx;
    private var btReqQueue;
    private var _timer;

    function initialize() {
        btCtx = BluetoothContext.getInstance();
        btReqQueue = CommunicationQueue.getInstance();
    }

    function enableTrainingMode() {
        _enableNotifications();
        _sendWriteCommands(btCtx.TRAINING_MODE);
    }

    function resetDevice() {
        _timer = new Timer.Timer();
        _sendWriteCommands(btCtx.INITIAL_STATE);
        btReqQueue.run();
        _timer.start(method(:runRequests), 1000, true);
              
    }

    private function _sendWriteCommands(command) {
        var devices = Ble.getPairedDevices() as Ble.Iterator;
        var currentDevice = devices.next();
        while (currentDevice != null ) {
            try { 
                if (currentDevice.isConnected()) {
                    var service = currentDevice.getService(btCtx.customService());
                    var controller = service.getCharacteristic(btCtx.customServiceControl());
                    btReqQueue.add(controller, btReqQueue.CHARACTERISTIC_WRITE, command );
                } else {
                    System.println("Warning a device is not paired fully");
                }
            } catch (e) {
                System.println(e.getErrorMessage());
            }
            currentDevice = devices.next();
        }
    }

    private function _enableNotifications() {
        var devices = Ble.getPairedDevices() as Ble.Iterator;
        var currentDevice = devices.next() as Ble.Device;
        while (currentDevice != null ) {
            try {
                if (currentDevice.isConnected()) {
                    var service = currentDevice.getService(btCtx.customService());
                    var read = service.getCharacteristic(btCtx.customServiceRead());
                    btReqQueue.add(read, btReqQueue.DESCRIPTOR_WRITE, btCtx.ENABLE_NOTIFY);
                } else {
                    System.println("Warning a device is not paired fully");
                }
            } catch (e) {
                System.println(e.getErrorMessage());
            }
            currentDevice = devices.next();
        }
    }

    function runRequests() {
        var isFinished;
        if (!btReqQueue.isRunning()) {
            isFinished = btReqQueue.run();
            if (isFinished) {
                _timer.stop();
            }
        }
    }
}
    
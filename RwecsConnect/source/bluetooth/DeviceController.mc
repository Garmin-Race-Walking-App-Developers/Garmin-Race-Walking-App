using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;

class DeviceController {
    private var btCtx;
    private var btReqQueue;

    function initialize() {
        btCtx = BluetoothContext.getInstance();
        btReqQueue = CommunicationQueue.getInstance();
    }

    function enableTrainingMode() {
        _enableNotifications();
        _sendWriteCommands(btCtx.TRAINING_MODE);
        btReqQueue.run();
    }

    function resetDevice() {
        _sendWriteCommands(btCtx.INITIAL_STATE);
        btReqQueue.run();
    }

    private function _sendWriteCommands(command) {
        var devices = Ble.getPairedDevices() as Ble.Iterator;
        var currentDevice = devices.next();
        while (currentDevice != null ) {
            try {
                var service = currentDevice.getService(btCtx.customService());
                var controller = service.getCharacteristic(btCtx.customServiceControl());
                btReqQueue.add(controller, btReqQueue.CHARACTERISTIC_WRITE, command );
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
                var service = currentDevice.getService(btCtx.customService());
                var read = service.getCharacteristic(btCtx.customServiceRead());
                btReqQueue.add(read, btReqQueue.DESCRIPTOR_WRITE, btCtx.ENABLE_NOTIFY);
            } catch (e) {
                System.println(e.getErrorMessage());
            }
            currentDevice = devices.next();
        }
    }
}
    
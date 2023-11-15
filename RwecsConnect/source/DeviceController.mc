using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;

class DeviceController {
    private var btCtx;

    function initialize() {
        btCtx = BluetoothContext.getInstance();
    }

    function enableTrainingMode() {
        var devices = Ble.getPairedDevices() as Ble.Iterator;
        sendCommands(devices, btCtx.TRAINING_MODE, Ble.WRITE_TYPE_DEFAULT);
    }

    private function sendCommands(devices, command, writeType) {
        var currentDevice = devices.next();
        while (currentDevice != null ) {
            var service = currentDevice.getService(btCtx.customService());
            var controller = service.getCharacteristic(btCtx.customServiceControl());
            try {
                controller.requestWrite(command, { :writeType => writeType });
            } catch (e) {
                System.println(e.getErrorMessage());
            }
            currentDevice = devices.next();
        }
    }
}
    
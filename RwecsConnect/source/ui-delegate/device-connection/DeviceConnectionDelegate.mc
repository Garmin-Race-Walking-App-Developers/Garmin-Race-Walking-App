import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.BluetoothLowEnergy as Ble;

class DeviceConnectionDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as Symbol) as Void {
        try {
            var deviceName = item.getId();
            BluetoothHandler.getInstance().connectToDeviceByName(deviceName);
            var progressBar = new WatchUi.ProgressBar(
                "Connecting to\n" + deviceName,
                null
            );
            WatchUi.switchToView(progressBar, new DeviceConnectionProgressDelegate(progressBar, deviceName), WatchUi.SLIDE_LEFT);
        } catch (e) {
            System.println(e.getErrorMessage());
        }
    }
}
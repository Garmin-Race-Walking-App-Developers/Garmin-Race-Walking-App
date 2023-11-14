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
            BluetoothHandler.getInstance().connectToDeviceByName(item.getId());
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        } catch (e) {
            System.println(e.getErrorMessage());
        }
    }

}
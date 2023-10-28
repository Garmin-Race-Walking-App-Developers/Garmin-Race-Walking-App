import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.BluetoothLowEnergy as Ble;

class DeviceConnectionDelegate extends WatchUi.Menu2InputDelegate {
    var btHandler;

    function initialize(btHandler) {
        Menu2InputDelegate.initialize();
        self.btHandler = btHandler;
        Ble.setDelegate(btHandler);
    }

    function onSelect(item as Symbol) as Void {
        try {
            btHandler.connectToDeviceByName(item.getId());
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        } catch (e) {
            System.println(e.getErrorMessage());
        }
    }

}
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class RwecsConnectMenuDelegate extends WatchUi.Menu2InputDelegate {
    private const _defaultAlarmLimitValue = 40;
    protected var btHandler;

    function initialize() {
        Menu2InputDelegate.initialize();
        btHandler = new BluetoothHandler();
    }

    function onSelect(item as WatchUi.MenuItem) {
        if (item.getId().equals("start")) {
            var view = new RwecsWorkoutView(_defaultAlarmLimitValue);
            WatchUi.pushView(view, new RwecsWorkoutDelegate(view, btHandler), WatchUi.SLIDE_UP); 
        } 
        else if (item.getId().equals("settings")) {
            var view = new RwecsSettingsView(_defaultAlarmLimitValue);
            WatchUi.pushView(view, new RwecsSettingsDelegate(view), WatchUi.SLIDE_UP); 
        }
        else if (item.getId().equals("connect")) {
            var progressBar = new WatchUi.ProgressBar(
                "Searching for \nRWECS devices...",
                null
            );
            WatchUi.pushView(progressBar, new ConnectionProgressDelegate(btHandler, progressBar), WatchUi.SLIDE_LEFT);
        }
    }
}
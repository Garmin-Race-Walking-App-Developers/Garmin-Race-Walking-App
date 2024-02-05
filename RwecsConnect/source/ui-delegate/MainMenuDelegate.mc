import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) {
        if (item.getId().equals("start")) {
            if (BluetoothHandler.getInstance().hasConnectedDevices()) {
                var progressBar = new WatchUi.ProgressBar(
                    "Preparing RWECS\n",
                    null
                );
                WatchUi.switchToView(progressBar, new WorkoutPrepDelegate(), WatchUi.SLIDE_LEFT);
            }

            else {
                var view = new ErrorView();
                WatchUi.pushView(view, new ErrorDelegate(view), WatchUi.SLIDE_UP);
            } 
        } 
        else if (item.getId().equals("settings")) {
            var view = new SettingsView();
            WatchUi.pushView(view, new SettingsDelegate(view), WatchUi.SLIDE_UP); 
        }
        else if (item.getId().equals("pair")) {
            var progressBar = new WatchUi.ProgressBar(
                "Searching for \nRWECS devices...",
                null
            );
            WatchUi.pushView(progressBar, new DeviceSearchProgressDelegate(progressBar), WatchUi.SLIDE_LEFT);
        }
    }
}

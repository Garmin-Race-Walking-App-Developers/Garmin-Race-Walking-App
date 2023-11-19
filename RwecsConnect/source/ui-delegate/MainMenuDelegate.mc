import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {
    private const _defaultAlarmLimitValue = 40;

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) {
        if (item.getId().equals("start")) {
            var view = new WorkoutView(_defaultAlarmLimitValue);
            WatchUi.pushView(view, new WorkoutDelegate(view), WatchUi.SLIDE_UP); 
        } 
        else if (item.getId().equals("settings")) {
            var view = new SettingsView(_defaultAlarmLimitValue);
            WatchUi.pushView(view, new SettingsDelegate(view), WatchUi.SLIDE_UP); 
        }
        else if (item.getId().equals("connect")) {
            var progressBar = new WatchUi.ProgressBar(
                "Searching for \nRWECS devices...",
                null
            );
            WatchUi.pushView(progressBar, new DeviceSearchProgressDelegate(progressBar), WatchUi.SLIDE_LEFT);
        }
    }
}

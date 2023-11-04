import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class RwecsConnectMenuDelegate extends WatchUi.Menu2InputDelegate {
    private const _defaultAlarmLimitValue = 40;

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) {
        if (item.getId().equals("start")) {
            var view = new WorkoutView();
            WatchUi.pushView(view, new RwecsWorkoutDelegate(view), WatchUi.SLIDE_UP); 
        } 
        else if (item.getId().equals("settings")) {
            var view = new RwecsSettingsView(_defaultAlarmLimitValue);
            WatchUi.pushView(view, new SettingsDelegate(view), WatchUi.SLIDE_UP); 
        }
        else if (item.getId().equals("connect")) {
            var progressBar = new WatchUi.ProgressBar(
                "Searching for \nRWECS devices...",
                null
            );
            WatchUi.pushView(progressBar, new ConnectionProgressDelegate(progressBar), WatchUi.SLIDE_LEFT);
        }
    }
}

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
            var view = new RwecsWorkoutView(_defaultAlarmLimitValue);
            WatchUi.pushView(view, new RwecsWorkoutDelegate(view), WatchUi.SLIDE_UP); 
        } 
        else if (item.getId().equals("settings")) {
            var view = new RwecsSettingsView(_defaultAlarmLimitValue);
            WatchUi.pushView(view, new RwecsSettingsDelegate(view), WatchUi.SLIDE_UP); 
        }
    }
}
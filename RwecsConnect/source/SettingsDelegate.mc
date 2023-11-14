import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class SettingsDelegate extends WatchUi.InputDelegate {
    var _view;

    function initialize(view) {
        InputDelegate.initialize();
        _view = view;  
    }

    function onKey(keyEvent as KeyEvent) {
        //Down button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_DOWN) {
            _view.updateAlarmLimitValue(false);
        }

        //Up button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_UP) {
            _view.updateAlarmLimitValue(true);
        }

        //Start button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            var alarmLimitValue = _view.getAlarmLimitValue();
            var newWorkoutView = new RwecsWorkoutView(alarmLimitValue);
            WatchUi.switchToView(newWorkoutView, new RwecsWorkoutDelegate(newWorkoutView), WatchUi.SLIDE_UP); 
        }

        //Back button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.switchToView(new RwecsConnectMenu(), new RwecsConnectMenuDelegate(), WatchUi.SLIDE_DOWN);
        }
        return true;
    }
}
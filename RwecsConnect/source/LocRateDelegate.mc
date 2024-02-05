import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class LocRateDelegate extends WatchUi.InputDelegate {
    var _view;

    function initialize(view) {
        InputDelegate.initialize();
        _view = view;  
    }

    function onKey(keyEvent as KeyEvent) {
        //Down button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_DOWN) {
            _view.updateLocRateValue(false);
        }

        //Up button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_UP) {
            _view.updateLocRateValue(true);
        }

        //Back button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            var newSettingsView = new SettingsMenu();
            WatchUi.switchToView(newSettingsView, new SettingsMenuDelegate(newSettingsView), WatchUi.SLIDE_DOWN);
        }
        return true;
    }
}

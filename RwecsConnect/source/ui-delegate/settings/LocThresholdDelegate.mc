import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class LocThresholdDelegate extends WatchUi.InputDelegate {
    var _settingsCtx;

    function initialize() {
        InputDelegate.initialize();
        _settingsCtx =  SettingsContext.getInstance();
    }

    function onKey(keyEvent as KeyEvent) {
        //Down button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_DOWN) {
            _settingsCtx.decrementThresholdValue();
            WatchUi.requestUpdate();
        }

        //Up button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_UP) {
            _settingsCtx.incrementThresholdValue();
            WatchUi.requestUpdate();
        }

        //Back button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_DOWN);
        }
        return true;
    }
}

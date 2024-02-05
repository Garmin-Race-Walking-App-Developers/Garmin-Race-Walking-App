import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class SettingsViewDelegate extends WatchUi.InputDelegate {
    private var _view;
    private var _settingsCtx;

    function initialize(view) {
        InputDelegate.initialize();
        _view = view;
        _settingsCtx = SettingsContext.getInstance();
    }

    function onKey(keyEvent as KeyEvent) {
        //Down button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_DOWN) {
            _settingsCtx.decrementAlarmLimit();
            // _view.updateAlarmLimitElement();
        }

        //Up button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_UP) {
            _settingsCtx.incrementAlarmLimit();
            // _view.updateAlarmLimitElement();
        }

        //Back button is pressed
        else if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.switchToView(new MainMenu(), new MainMenuDelegate(), WatchUi.SLIDE_DOWN);
        }
        return true;
    }
}
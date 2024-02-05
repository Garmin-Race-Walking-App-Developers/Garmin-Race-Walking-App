import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class ErrorDelegate extends WatchUi.InputDelegate {
    private var _view;
    private var _settingsCtx;

    function initialize(view) {
        InputDelegate.initialize();
        _view = view;
    }

    function onKey(keyEvent as KeyEvent) {
        //Back button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.switchToView(new MainMenu(), new MainMenuDelegate(), WatchUi.SLIDE_DOWN);
        }
        return true;
    }
}
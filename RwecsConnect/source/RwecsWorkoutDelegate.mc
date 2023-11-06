import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class RwecsWorkoutDelegate extends WatchUi.InputDelegate {
    var _view;

    function initialize(view) {
        InputDelegate.initialize();
        _view = view;  
    }

    function onKey(keyEvent as KeyEvent) {
        //Back button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.switchToView(new RwecsConnectMenu(), new RwecsConnectMenuDelegate(), WatchUi.SLIDE_DOWN);
        }
        return true;
    }
}
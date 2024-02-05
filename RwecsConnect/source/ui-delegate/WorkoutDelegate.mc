import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;
import Toybox.Lang;

class WorkoutDelegate extends WatchUi.InputDelegate {
    private var _parentView as WorkoutView;
    private var _deviceController;
    

    function initialize(view, deviceController) {
        InputDelegate.initialize();
        _parentView = view;
        _deviceController = deviceController;
    }

    function onKey(keyEvent as KeyEvent) {
        
        if (keyEvent.getKey() == WatchUi.KEY_UP) {
            _parentView.resetTimer();
        }

        if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
           _parentView.startStopTimer(); 
        }

        //Back button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            _parentView.killTimer();
            _deviceController.resetDevice();
            WatchUi.popView(WatchUi.SLIDE_DOWN);
        }

        return true;
    }
}

import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;
using Toybox.BluetoothLowEnergy as Ble;

class RwecsWorkoutDelegate extends WatchUi.InputDelegate {
    var _view;
    protected var btHandler;

    function initialize(view, btHandler) {
        InputDelegate.initialize();
        _view = view;  

        self.btHandler = btHandler;
    }

    function onKey(keyEvent as KeyEvent) {
        //Back button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.switchToView(new RwecsConnectMenu(), new RwecsConnectMenuDelegate(), WatchUi.SLIDE_DOWN);
        }
        if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
           startWorkout(); 
        }
        return true;
    }

    private function startWorkout() {
        btHandler.enableTrainingMode();
    }

}
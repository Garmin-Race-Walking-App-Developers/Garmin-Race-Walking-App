import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;
using Toybox.BluetoothLowEnergy as Ble;

class RwecsWorkoutDelegate extends WatchUi.InputDelegate {
    private var _view;
    private var _deviceController;


    function initialize(view) {
        InputDelegate.initialize();
        _view = view; 
        _deviceController = new DeviceController(); 
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
        _deviceController.enableTrainingMode();
    }

}
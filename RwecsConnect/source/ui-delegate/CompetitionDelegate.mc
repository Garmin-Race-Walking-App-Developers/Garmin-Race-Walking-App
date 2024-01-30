import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;
using Toybox.BluetoothLowEnergy as Ble;

class CompetitionDelegate extends WatchUi.InputDelegate {
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
            _deviceController.resetDevice();
            WatchUi.switchToView(new MainMenu(), new MainMenuDelegate(), WatchUi.SLIDE_DOWN);
        }
        if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
           startWorkout(); 
        }
        return true;
    }

    private function startWorkout() {
        _deviceController.enableTrainingMode();
        _view.startFlightTimeTracking();
    }

}
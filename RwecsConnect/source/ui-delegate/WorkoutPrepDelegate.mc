import Toybox.WatchUi;
import Toybox.Timer;
using Toybox.BluetoothLowEnergy as Ble;

class WorkoutPrepDelegate extends WatchUi.BehaviorDelegate {
    private var _timer;
    private var _timerCount;
    private var _deviceController;

    function initialize() {
        BehaviorDelegate.initialize();

        _timerCount = 1;
        _timer = new Timer.Timer();
        _deviceController = new DeviceController();
        _deviceController.enableTrainingMode();
        _timer.start(method(:timerCallBack), 1000, true);
        
    }

    function onBack() {
        return true;
    }
    
    function timerCallBack() {
        _timerCount++;

        if (_timerCount == 2) {
            _timer.stop();

            var view = new WorkoutView();
            WatchUi.popView(WatchUi.SLIDE_UP);
            WatchUi.pushView(view, new WorkoutDelegate(view, _deviceController), WatchUi.SLIDE_UP);
        }
    }
}
import Toybox.WatchUi;
import Toybox.Timer;
using Toybox.BluetoothLowEnergy as Ble;

class WorkoutPrepDelegate extends WatchUi.BehaviorDelegate {
    private var _timer;
    private var _timerCount;
    private var _deviceController;
    private var _btRequestQueue;

    function initialize() {
        BehaviorDelegate.initialize();

        _timerCount = 1;
        _timer = new Timer.Timer();
        _deviceController = new DeviceController();
        _deviceController.enableTrainingMode();
        _btRequestQueue = CommunicationQueue.getInstance();
        _timer.start(method(:timerCallBack), 500, true);
        
    }

    function onBack() {
        return true;
    }
    
    function timerCallBack() {
        var isFinished;
        if (!_btRequestQueue.isRunning()) {
            isFinished = _btRequestQueue.run();
            if (isFinished) {
                _timer.stop();
                var view = new WorkoutView();
                WatchUi.popView(WatchUi.SLIDE_UP);
                WatchUi.pushView(view, new WorkoutDelegate(view, _deviceController), WatchUi.SLIDE_UP);
            }
        }
        
        _timerCount++;

        if (_timerCount == 15) {
            _timer.stop();
            WatchUi.popView(WatchUi.SLIDE_UP);
        }
    }
}
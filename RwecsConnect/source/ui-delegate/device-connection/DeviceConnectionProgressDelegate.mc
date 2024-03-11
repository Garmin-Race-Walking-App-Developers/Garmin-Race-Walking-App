import Toybox.WatchUi;
import Toybox.Timer;
using Toybox.BluetoothLowEnergy as Ble;

class DeviceConnectionProgressDelegate extends WatchUi.BehaviorDelegate {
    private var _btHandler;
    private var _timer;
    private var _timerCount;
    private var _progressBar;
    private var _deviceName;

    function initialize(progressBar, deviceName) {
        BehaviorDelegate.initialize();
        _btHandler = BluetoothHandler.getInstance();
        _progressBar = progressBar;
        _deviceName = deviceName;
        _timerCount = 0;
        _timer = new Timer.Timer();

        _timer.start(method(:timerCallBack), 1000, true);
    }

    function onBack() {
        return true;
    }
    
    function timerCallBack() {
        _timerCount++;

        if (_btHandler.allDevicesConnected()) {
            _timer.stop();
            WatchUi.popView(WatchUi.SLIDE_UP);    
        } 
        else if (_timerCount == 10 ) {
            _progressBar.setDisplayString(
                "Failed to connect\n unpairing...");
        }
        else if (_timerCount > 10) {
            _timer.stop();
            _btHandler.undoPairing(_deviceName);
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
    }
}
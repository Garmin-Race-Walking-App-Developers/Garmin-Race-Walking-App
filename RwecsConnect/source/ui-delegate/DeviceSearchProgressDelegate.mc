import Toybox.WatchUi;
import Toybox.Timer;
using Toybox.BluetoothLowEnergy as Ble;

class DeviceSearchProgressDelegate extends WatchUi.BehaviorDelegate {
    private var btHandler;
    private var timer;
    private var timerCount;
    private var progressBar;

    function initialize(progressBar) {
        BehaviorDelegate.initialize();
        btHandler = BluetoothHandler.getInstance();
        self.progressBar = progressBar;
        timerCount = 0;
        timer = new Timer.Timer();

        btHandler.startScan();
        timer.start(method(:timerCallBack), 5000, true);
    }

    function onBack() {
        endLoop();
        return true;
    }
    
    function timerCallBack() {
        timerCount++;
        var connectableDevices =  btHandler.getConnectableDevices();

        if (connectableDevices.size() > 0) {
            endLoop();
            WatchUi.switchToView(new DeviceConnectionMenu(connectableDevices.keys()), new DeviceConnectionDelegate(), WatchUi.SLIDE_UP);    
        } 
        else if (timerCount == 3 ) {
            progressBar.setDisplayString(
                "No devices nearby \n returning");
            timer.stop();
            timer.start(method(:timerCallBack), 1000, true);
        }
        else if (timerCount > 3) {
            endLoop();
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
    }

    private function endLoop() {
        timer.stop();
        btHandler.stopScan();
    }
}
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Math;

class WorkoutView extends WatchUi.View {
    
    static var HRATE_LABEL = "hrLabel";
    private var LOC_LABEL = "locLabel";
    private var TIMER_LABEL = "timerLabel";
   
    private var _hrString as String;
    private var _locString as String;
    private var _timerString as String;
   
    private var _timer as Timer.Timer?;
    private var _timerValue as Number;
    private var _paused as Boolean;

    //intialize the workout view
    function initialize() {
        View.initialize();
        
        _hrString = "---";
        _locString = "--";
        _timerString = "0:00:00";
        
        _timerValue = 0;
        _paused = false;
        
        _timer = new Timer.Timer();
        _timer.start(method(:onTimer), 1000, true);
        
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE] as Array<SensorType>);
        Sensor.enableSensorEvents(method(:onSnsr));
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LayoutWorkout(dc));    
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        
        View.onUpdate(dc);

        updateHeartRate(dc);
        updateLOC(dc);
        updateTimer(dc);
    }

    //! Handle sensor updates
    //! @param sensorInfo Updated sensor data
    function onSnsr(sensorInfo as Info) as Void {
        var heartRate = sensorInfo.heartRate;

        if (heartRate != null) {
            _hrString = heartRate.toString();

        } else {
            _hrString = "---";
        }

        WatchUi.requestUpdate();
    }

    //increment the timer by 1 second
    function onTimer() as Void {
        
        if (_paused == false) {
            _timerValue++;
        }

        var hours = Math.floor(_timerValue / 3600);
        var minutes = Math.floor((_timerValue % 3600) / 60);
        var seconds = _timerValue % 60;

        _timerString = hours + ":" + minutes.format("%02d") + ":" + seconds.format("%02d");

        WatchUi.requestUpdate();
    }

    //start and stop the timer in the workout view
    function startStopTimer() as Void {
        if (_paused == false) {
            _paused = true;
        } else {
            _paused = false;
        }

        onTimer();
    }

    //reset the timer in the workout view
    function resetTimer() as Void {
        _timerValue = 0;
        _timerString = "0:00:00";
        
        WatchUi.requestUpdate();
    }

    /**
    * Function to kill timer when the view is exited
    */
    function killTimer() {
       _timer.stop(); 
    }

      //update the heart rate in the workout view
    function updateHeartRate(dc) {
       findDrawableById(HRATE_LABEL).setText(_hrString);
    }

    //update the loss f contact (flight time) in the workout view
    function updateLOC(dc) {
        _locString = BluetoothHandler.getInstance().peakFlightTime.toString();
        findDrawableById(LOC_LABEL).setText(_locString);
    }

    //update the timer in the workout view
    function updateTimer(dc) {
        var textColor = _paused ? Graphics.COLOR_YELLOW : Graphics.COLOR_WHITE;
        findDrawableById(TIMER_LABEL).setText(_timerString);
        findDrawableById(TIMER_LABEL).setColor(textColor);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}
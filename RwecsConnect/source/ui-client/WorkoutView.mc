import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Math;

class WorkoutView extends WatchUi.View {
    private var timerIcon;
    private var locIcon;
    private var heartRateIcon;
   
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
        heartRateIcon = WatchUi.loadResource(Rez.Drawables.heartRate);
        locIcon = WatchUi.loadResource(Rez.Drawables.loc);
        timerIcon = WatchUi.loadResource(Rez.Drawables.timer);
       
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        var x = dc.getWidth()/2;
        var y = dc.getHeight()/2;
        
        View.onUpdate(dc);

        insertBorders(dc, x, y);
        insertTrainingImages(dc, x, y);

        updateHeartRate(dc, x, y);
        updateLOC(dc, x, y);
        updateTimer(dc, x, y);
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

    //insert the borders in the workout view
    function insertBorders(dc, x, y) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, y-40, x+100, y-40);
        dc.drawLine(0, y+40, x+100, y+40);
    }

    //insert the training images in the workout view
    function insertTrainingImages(dc, x, y) {  
        dc.drawBitmap(x-90, y-100, heartRateIcon);
        dc.drawBitmap(x-100, y-35, locIcon);
        dc.drawBitmap(x-90, y+50, timerIcon);
    }

    //update the heart rate in the workout view
    function updateHeartRate(dc, x, y) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x+15, y-100, Graphics.FONT_NUMBER_MEDIUM, _hrString, Graphics.TEXT_JUSTIFY_CENTER);
    }

    //update the loss f contact (flight time) in the workout view
    function updateLOC(dc, x, y) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x+15, y-45, Graphics.FONT_NUMBER_HOT, BluetoothHandler.getInstance().averageFlightTime, Graphics.TEXT_JUSTIFY_CENTER);
    }

    //update the timer in the workout view
    function updateTimer(dc, x, y) {
        var textColor = _paused ? Graphics.COLOR_YELLOW : Graphics.COLOR_WHITE;
        dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x+15, y+50, Graphics.FONT_NUMBER_MILD, _timerString, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}
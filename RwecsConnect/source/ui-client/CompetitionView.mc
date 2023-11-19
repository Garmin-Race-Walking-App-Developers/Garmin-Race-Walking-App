import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class CompetitionView extends WatchUi.View {
    private var _deviceController;

    private var _sensor1NameElement;
    private var _sensor2NameElement;
    private var _sensor1BatteryElement;
    private var _sensor2BatteryElement;

    private var _alarmLimitValueElement;
    private var _alarmLimitValue;

    var currentSensor1BatteryLevel = 100;
    var currentSensor2BatteryLevel = 100;

    var currentSensor1FlightTimeStatus = 0;
    var currentSensor2FlightTimeStatus = 0;

    var batteryTimer;
    var flightTimeTimer;

    function initialize(alarmLimitValue) {
        View.initialize();
        _alarmLimitValue = alarmLimitValue;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WorkoutLayout(dc));

        _sensor1NameElement = findDrawableById("sensor1_name");
        _sensor2NameElement = findDrawableById("sensor2_name");
        _sensor1BatteryElement = findDrawableById("sensor1_battery");
        _sensor2BatteryElement = findDrawableById("sensor2_battery");

        _alarmLimitValueElement = findDrawableById("alarm_limit");
        updateAlarmLimitValueElement();

        batteryTimer = new Timer.Timer();
        batteryTimer.start(method(:updateBatteryLevel), 2000, true);

        flightTimeTimer = new Timer.Timer();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        batteryTimer.stop();
        flightTimeTimer.stop();
    }

    // TODO: Implement real function that uses batttery level coming from RWECS sensors
    function updateBatteryLevel() as Void {
        if (currentSensor1BatteryLevel >= 3) {
            currentSensor1BatteryLevel -= 3;
        } else {
            currentSensor1BatteryLevel = 0;
        }

        if (currentSensor2BatteryLevel >= 3) {
            currentSensor2BatteryLevel -= 3;
        } else {
            currentSensor2BatteryLevel = 0;
        }

        _sensor1BatteryElement.setText(currentSensor1BatteryLevel.toString() + "%");
        if (currentSensor1BatteryLevel <= 30) {
            _sensor1BatteryElement.setColor(Graphics.COLOR_YELLOW);
        }
        if (currentSensor1BatteryLevel <= 10) {
            _sensor1BatteryElement.setColor(Graphics.COLOR_RED);
        }

        _sensor2BatteryElement.setText(currentSensor2BatteryLevel.toString() + "%");
        if (currentSensor2BatteryLevel <= 30) {
            _sensor2BatteryElement.setColor(Graphics.COLOR_YELLOW);
        }

        if (currentSensor2BatteryLevel <= 10) {
            _sensor2BatteryElement.setColor(Graphics.COLOR_RED);
        }

        WatchUi.requestUpdate();
    }

    function startFlightTimeTracking() {
        flightTimeTimer.start(method(:updateFlightTimeStatus), 100, true);
    }

    // TODO: Implement real function that uses flight time data coming from RWECS sensors
    function updateFlightTimeStatus() as Void {
        // Generate random flight time data
        currentSensor1FlightTimeStatus = Math.rand() % 2;
        currentSensor2FlightTimeStatus = Math.rand() % 2;

        // Flash red if flight time data exceeds provided threshold or the sensors ran out of battery
        // Flash white if flight time data is within provided threashould
        if (currentSensor1FlightTimeStatus == 1 || currentSensor1BatteryLevel == 0) {
            _sensor1NameElement.setColor(Graphics.COLOR_RED);
        } else if (currentSensor1FlightTimeStatus == 0) {
            _sensor1NameElement.setColor(Graphics.COLOR_WHITE);
        }
    
        if (currentSensor2FlightTimeStatus == 1 || currentSensor2BatteryLevel == 0) {
            _sensor2NameElement.setColor(Graphics.COLOR_RED);
        } else if (currentSensor2FlightTimeStatus == 0) {
            _sensor2NameElement.setColor(Graphics.COLOR_WHITE);
        }

        WatchUi.requestUpdate();
    }

    function updateAlarmLimitValueElement() {
        _alarmLimitValueElement.setText(_alarmLimitValue.toString() + "ms");
    }
}
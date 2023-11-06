import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class RwecsSettingsView extends WatchUi.View {
    private var _alarmLimitValueElement;
    private var _alarmLimitValue;

    function initialize(alarmLimitValue) {
        View.initialize();
        _alarmLimitValue = alarmLimitValue;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.SettingsLayout(dc));

        _alarmLimitValueElement = findDrawableById("alarm_limit");
        updateAlarmLimitValueElement();
    }

    function updateAlarmLimitValueElement() {
        _alarmLimitValueElement.setText(_alarmLimitValue.toString() + "ms");
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
    }

    function updateAlarmLimitValue(increment) as Void {
        if (increment) {
            _alarmLimitValue += 10;
        }

        else if (_alarmLimitValue >= 10){
            _alarmLimitValue -= 10;
        }

        _alarmLimitValueElement.setText(_alarmLimitValue.toString() + "ms");
        WatchUi.requestUpdate();
    }

    function getAlarmLimitValue() {
        return _alarmLimitValue;
    }
}
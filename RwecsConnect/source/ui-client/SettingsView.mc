import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class SettingsView extends WatchUi.View {
    private var _alarmLimitElement;
    private var _settingsCtx;

    function initialize() {
        View.initialize();
        _settingsCtx = SettingsContext.getInstance();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.SettingsLayout(dc));

        _alarmLimitElement = findDrawableById("alarm_limit");
        updateAlarmLimitElement();
    }

    function updateAlarmLimitElement() {
        _alarmLimitElement.setText(_settingsCtx.getAlarmLimit().toString() + "ms");
        WatchUi.requestUpdate();
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
}
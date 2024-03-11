import Toybox.Application;
import Toybox.Graphics;
import Toybox.WatchUi;

class LocThresholdView extends WatchUi.View {
    private var _locThresholdValueElement;
    private var _locThresholdValue;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LocThresholdLayout(dc));
        updateLocThresholdValueElement();
    }

    function updateLocThresholdValueElement() {
        _locThresholdValue = SettingsContext.getInstance().getThresholdValue();
        _locThresholdValueElement = findDrawableById(SettingsContext.THRESHOLD_VALUE);
        _locThresholdValueElement.setText(_locThresholdValue.toString() + "ms");
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        updateLocThresholdValueElement();
        View.onUpdate(dc);
    }
}

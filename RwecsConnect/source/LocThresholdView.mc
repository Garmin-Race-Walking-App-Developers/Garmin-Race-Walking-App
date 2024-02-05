import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class LocThresholdView extends WatchUi.View {
    private var _locThresholdValueElement;
    private var _locThresholdValue;

    function initialize() {
        View.initialize();
        
        if (Storage.getValue("loc_threshold") == null) {
            _locThresholdValue = 10;
            Storage.setValue("loc_threshold", _locThresholdValue);
        }
        else {
            _locThresholdValue = Storage.getValue("loc_threshold");
      }
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LocThresholdLayout(dc));

        _locThresholdValueElement = findDrawableById("loc_threshold");
        updateLocThresholdValueElement();
    }

    function updateLocThresholdValueElement() {
        _locThresholdValueElement.setText(_locThresholdValue.toString() + "ms");
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

    function updateLocThresholdValue(increment) as Void {
        if (increment) {
            _locThresholdValue += 2;
        }

        else if (_locThresholdValue >= 2){
            _locThresholdValue -= 2;
        }

        _locThresholdValueElement.setText(_locThresholdValue.toString() + "ms");
        Storage.setValue("loc_threshold", _locThresholdValue);
        WatchUi.requestUpdate();
    }

    function getLocThresholdValue() {
        return _locThresholdValue;
    }
}

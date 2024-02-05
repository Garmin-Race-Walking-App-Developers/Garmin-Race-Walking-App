import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Math;

class LocRateView extends WatchUi.View {
    private var _locRateValueElement;
    private var _locRateValue;

    function initialize() {
        View.initialize();
                
        if (Storage.getValue("loc_rate") == null) {
            _locRateValue = 5;
            Storage.setValue("loc_rate", _locRateValue);
        }
        else {
            _locRateValue = Storage.getValue("loc_rate");
      }
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LocRateLayout(dc));

        _locRateValueElement = findDrawableById("loc_rate");
        updateLocRateValueElement();
    }

    function updateLocRateValueElement() {
        _locRateValueElement.setText(_locRateValue.toString() + "ms");
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

    function updateLocRateValue(increment) as Void {
        if (increment) {
            _locRateValue += 1;
        }

        else if (_locRateValue > 1){
            _locRateValue -= 1;
        }

        _locRateValueElement.setText(_locRateValue.toString() + "ms");
        Storage.setValue("loc_rate", _locRateValue);
        WatchUi.requestUpdate();
    }

    function getLocRateValue() {
        return _locRateValue;
    }
}

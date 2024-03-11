import Toybox.Application;
import Toybox.Graphics;
import Toybox.WatchUi;

class LocRateView extends WatchUi.View {
    private var _locRateValueElement;
    private var _locRateValue;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.LocRateLayout(dc));
        updateLocRateValueElement();
    }

    function updateLocRateValueElement() {
        _locRateValue = SettingsContext.getInstance().getRateValue();
        _locRateValueElement = findDrawableById(SettingsContext.RATE_VALUE);
        _locRateValueElement.setText(_locRateValue.toString() + "ms");
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        updateLocRateValueElement();
        View.onUpdate(dc);
    }
}

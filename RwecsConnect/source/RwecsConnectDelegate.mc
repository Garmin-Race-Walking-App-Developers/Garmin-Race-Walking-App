import Toybox.Lang;
import Toybox.WatchUi;

class RwecsConnectDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new RwecsConnectMenu(), new RwecsConnectMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onNextPage() as Boolean {
        WatchUi.pushView(new RwecsConnectMenu(), new RwecsConnectMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
}
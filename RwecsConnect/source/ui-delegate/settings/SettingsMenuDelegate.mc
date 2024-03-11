import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function  onSelect(item as WatchUi.MenuItem) {
          if (item.getId().equals("loc_threshold")) {
            WatchUi.pushView(new LocThresholdView(), new LocThresholdDelegate(), WatchUi.SLIDE_UP); 
        }    

        if (item.getId().equals("loc_rate")) {
            WatchUi.pushView(new LocRateView(), new LocRateDelegate(), WatchUi.SLIDE_UP); 
        }    
    }

    function onKey(keyEvent as KeyEvent) {
        //Back button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.popView();
        }
        return true;
    }
}

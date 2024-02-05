import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
    var _view;

    function initialize(view) {
        Menu2InputDelegate.initialize();
        _view = view;
    }

    function  onSelect(item as WatchUi.MenuItem) {
          if (item.getId().equals("loc_threshold")) {
            var view = new LocThresholdView();
            WatchUi.pushView(view, new LocThresholdDelegate(view), WatchUi.SLIDE_UP); 
        }    

        if (item.getId().equals("loc_rate")) {
            var view = new LocRateView();
            WatchUi.pushView(view, new LocRateDelegate(view), WatchUi.SLIDE_UP); 
        }    
    }

    function onKey(keyEvent as KeyEvent) {
        //Back button is pressed
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            var view = new MainMenu();
            WatchUi.switchToView(view, new MainMenuDelegate(), WatchUi.SLIDE_DOWN);
        }
        return true;
    }
}

import Toybox.WatchUi;

class MainMenu extends WatchUi.Menu2 {

    function initialize() {
        Menu2.initialize({:title=>"Exercise menu:"});
        addItems();
    }

    private function addItems() {
        addItem(new MenuItem("           Pair", null, "pair", null));
        addItem(new MenuItem("             Start", null, "start", null));
        addItem(new MenuItem("          Settings", null, "settings", null));
    }
}

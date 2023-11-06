import Toybox.WatchUi;

class RwecsConnectMenu extends WatchUi.Menu2 {
    private const menuOptions = {
        "start" => "             Start",
        "settings" => "          Settings"
    };

    function initialize() {
        Menu2.initialize({:title=>"Exercise menu:"});
        addItems(menuOptions);
    }

    private function addItems(options) {
        var names = options.keys();
        var labels = options.values();

        for (var i=0; i < options.size(); i++) {
            var name = names[i];
            var label = labels[i];
            addItem(new MenuItem(label, null, name, null));
        }
    }
}

import Toybox.WatchUi;

class SettingsMenu extends WatchUi.Menu2 {
    private const menuOptions = {
        "loc_threshold" => "      LOC Threshold",
        "loc_rate" => "      LOC Rate",
    };

    function initialize() {
        Menu2.initialize({:title=>"Settings menu:"});
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

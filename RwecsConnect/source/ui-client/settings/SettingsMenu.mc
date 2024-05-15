import Toybox.WatchUi;

class SettingsMenu extends WatchUi.Menu2 {
    private const menuOptions = {
        "loc_threshold" => "Alarm Threshold",
        "loc_rate" => "Step Sample Size",
    };

    function initialize() {
        Menu2.initialize({:title=>"Settings:"});
        addItems(menuOptions);
    }

    private function addItems(options) {
        var names = options.keys();
        var labels = options.values();

        for (var i = 0; i < options.size(); i++) {
            var name = names[i];
            var label = labels[i];
            addItem(new MenuItem(label, null, name, null));
        }
    }
}

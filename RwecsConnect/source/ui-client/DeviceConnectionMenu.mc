import Toybox.WatchUi;

class DeviceConnectionMenu extends WatchUi.Menu2 {
    
    function initialize(deviceNames) {
        Menu2.initialize({:title=>"Available devices:"});
        //TODO figure out how to add icon 
        // var icon = new WatchUi.Bitmap({
        //     :rezId=>Rez.Drawables.BLEIcon,
        //     :locX=>5,
        //     :locY=>5
        // });
        // setIcon(icon);
        addItems(deviceNames);
    }
    private function addItems(deviceNames) {
        for (var i=0; i < deviceNames.size(); i++) {
            var name = deviceNames[i];
            var label = "        " + name;
            addItem(new MenuItem(label, null, name, null));
        }
    }
}
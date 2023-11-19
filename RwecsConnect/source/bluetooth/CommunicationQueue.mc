using Toybox.System;
using Toybox.BluetoothLowEnergy as Ble;
using Toybox.WatchUi as Ui;

class CommunicationQueue {
    private static var instance = null;

    private var queue;
    private var isRunning;

    static enum {
		CHARACTERISTIC_WRITE,
		DESCRIPTOR_WRITE,
	}

    function initialize() {
        queue =[];
    }

    static function getInstance() {
        if (instance == null) { 
            instance = new CommunicationQueue();
        }
        return instance;
    }

    /**
    * Adds item to the request queue
    * @param: target{Charactertic} - Characteristic to send command to
    * @param: type{enum} - Command type based on this classes enum
    * @param: command{ByteArray} - command to write to the device
    */
    function add(target, type, command) {
        queue.add([target, type, command]);
    }

    function run() {
        if (queue.size() == 0) {
            return;
        }

        var target = queue[0][0];
        var type = queue[0][1];

        if (type == DESCRIPTOR_WRITE) {
            var cccd = target.getDescriptor(Ble.cccdUuid());
            cccd.requestWrite(queue[0][2]);
        }
        else if (type == CHARACTERISTIC_WRITE) {
            target.requestWrite(queue[0][2], { :writeType => Ble.WRITE_TYPE_DEFAULT });
        }

        if( queue.size() > 0 ) {
            queue = queue.slice(1,queue.size());
        } 
    }
}
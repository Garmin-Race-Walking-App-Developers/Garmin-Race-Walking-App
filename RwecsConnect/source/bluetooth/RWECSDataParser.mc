using Toybox.Lang as Lang;
using Toybox.Math as Math;

class RWECSDataParser {
    private var _FLIGHT_TIME_LIST_SIZE;
    private var _flightTimeList;
    private var currentIdx = 0;

    function initialize() {
        _FLIGHT_TIME_LIST_SIZE = SettingsContext.getInstance().getRateValue();
        _flightTimeList  = new [_FLIGHT_TIME_LIST_SIZE];
    }

    function updateFlightTimeList(value as Lang.ByteArray) {
        var flags = 0;
        var flightValue = 0;
        var timeStamp = 0;

        //Flags
        flags |= value[0]; 

        //FT in ms
        flightValue |= value[2];
        flightValue <<= 8;
        flightValue |= value[1] & 0xFF;

        //Relative time
        timeStamp |= value[5] & 0xFF;
        timeStamp <<= 8;
        timeStamp |= value[4] & 0xFF;
        timeStamp <<= 8;
        timeStamp |= value[3] & 0xFF;

        var parado = flags & 0x20;

        if (parado != 0) {
            System.println("Sensor stopped at " + timeStamp / 1000 + " s");
        } 
        
        else {
            if ((flags & 0xF0) == 0) {
                System.println("Sensor flight value " + flightValue + " ms at " + timeStamp / 1000 + " s");
            }
        }

        if (parado != 0 || _flightTimeList[0] == null) {
            getNewFlightValueList();
        }

        if (flightValue < 100 && flightValue > -200 && parado == 0x00 && (flags & 0xF0) == 0) {
            appendFlightValue(flightValue);
        }
    }

    function getPeakFlightTime() {
        return max(_flightTimeList);
    }

    function getNewFlightValueList() {
        _flightTimeList = new [_FLIGHT_TIME_LIST_SIZE];
        for (var i = 0; i < _FLIGHT_TIME_LIST_SIZE; i++) {
            _flightTimeList[i] = 0;
        }
    }

    // Circular buffer to preserve memory space
    private function appendFlightValue(flightValue as Lang.Number) {
        //Current index is the next spot to fill in the flight time list
        _flightTimeList[currentIdx] = flightValue;
        currentIdx++;

        // Reset current index
        if (currentIdx == _FLIGHT_TIME_LIST_SIZE) {
            currentIdx = 0;
        }
    }

    private function max(array as Lang.Array<Lang>) {
        var size = array.size();
        var max = 0;

        for (var i = 0; i < size; i++) {
            if (max < array[i]) {
                max = array[i];
            }
        }

        return max;
    }
}
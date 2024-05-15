using Toybox.Lang as Lang;
using Toybox.Math as Math;

class RWECSDataProcessor {
    private var _FLIGHT_TIME_LIST_SIZE;
    private var _flightTimeList;
    private var currentIdx = 0;

    function initialize() {
       self.getNewFlightValueList();
    }

    function update(rawData as Lang.ByteArray) {
        var flags = 0;
        var flightValue = 0;
        var timeStamp = 0;

        //Flags
        flags |= rawData[0]; 

        //FT in ms
        flightValue |= rawData[2];
        flightValue <<= 8;
        flightValue |= rawData[1] & 0xFF;

        //Relative time
        timeStamp |= rawData[5] & 0xFF;
        timeStamp <<= 8;
        timeStamp |= rawData[4] & 0xFF;
        timeStamp <<= 8;
        timeStamp |= rawData[3] & 0xFF;

        var stopped = flags & 0x20;

        if (stopped != 0) {
            System.println("Sensor stopped at " + timeStamp / 1000 + " s");
        } 

        // Debug print value - remove for build 
        // else if ((flags & 0xF0) == 0) {
        //     System.println("Sensor flight value " + flightValue + " ms at " + timeStamp / 1000 + " s");
        // }

        else if (flightValue < 100 && flightValue > -200 && stopped == 0x00 && (flags & 0xF0) == 0) {
            appendFlightValue(flightValue);
            checkStepViolation(flightValue);
        }

        return max(_flightTimeList);
    }

    function getNewFlightValueList() {
        _FLIGHT_TIME_LIST_SIZE = SettingsContext.getInstance().getRateValue();
        _flightTimeList  = new [_FLIGHT_TIME_LIST_SIZE];
        currentIdx = 0;
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

    // Checks if the flight time value exceeds threshold. Beeps on violation
    private function checkStepViolation(value) {
        if (value > SettingsContext.getInstance().getThresholdValue()) {
            var toneProfile =
            [
                new Attention.ToneProfile(500, 250)
            ];
            Attention.playTone({:toneProfile=>toneProfile});
        }
    }
}
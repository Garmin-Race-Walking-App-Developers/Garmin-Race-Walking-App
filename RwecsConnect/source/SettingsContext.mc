import Toybox.Application.Storage;

class SettingsContext {
    private static var _instance = null;
    private static var _thresholdValue;
    private static var _rateValue;
    static var THRESHOLD_VALUE = "loc_threshold";
    static var RATE_VALUE = "loc_rate";

    function initialize() {
        _thresholdValue = Storage.getValue(THRESHOLD_VALUE);
        if (_thresholdValue == null) {
            _thresholdValue = 40;
            saveSetting(THRESHOLD_VALUE, _thresholdValue);
        }

        _rateValue = Storage.getValue(RATE_VALUE);
        if (_thresholdValue == null) {
            _thresholdValue = 5;
            saveSetting(RATE_VALUE, _rateValue);
        }
    }

    static function getInstance() {
        if (_instance == null) { 
            _instance = new SettingsContext();
        }
        return _instance;
    }

    function getThresholdValue() {
        return _thresholdValue;
    }

    function incrementThresholdValue() {
        _thresholdValue += 2;
        saveSetting(THRESHOLD_VALUE, _thresholdValue);
    }

    function decrementThresholdValue() {
        if (_thresholdValue >= 2) {
            _thresholdValue -= 2;
            saveSetting(THRESHOLD_VALUE, _thresholdValue);
        }
    }

    function getRateValue() {
        return _rateValue;
    }

    function incrementRateValue() {
        _rateValue +=1;
        saveSetting(RATE_VALUE, _rateValue);
    }

    function decrementRateValue() {
        if (_rateValue > 0) {
        _rateValue -=1;
        saveSetting(RATE_VALUE, _rateValue);
        }
    }

    private function saveSetting(settingId, value) {
        Storage.setValue(settingId, value);
    }
}
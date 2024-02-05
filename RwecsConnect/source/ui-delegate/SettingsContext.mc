class SettingsContext {
    private static var _instance = null;
    private static var _alarmLimit;

    function initialize() {
        _alarmLimit = 45;
    }

    static function getInstance() {
        if (_instance == null) { 
            _instance = new SettingsContext();
        }
        return _instance;
    }

    function getAlarmLimit() {
        return _alarmLimit;
    }

    function incrementAlarmLimit() {
        _alarmLimit += 2;
    }

    function decrementAlarmLimit() {
        _alarmLimit -= 2;
    }
}
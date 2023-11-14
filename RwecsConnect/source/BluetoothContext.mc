import Toybox.Lang;
using Toybox.BluetoothLowEnergy as Ble;

class BluetoothContext {
    private static var instance = null;
    
    //Services
    private static var _customServiceUuid = Ble.stringToUuid("D973F2E0-B19E-11E2-9E96-0800200C9A66");
    private static var _customServiceReadUuid = Ble.stringToUuid("D973F2E1-B19E-11E2-9E96-0800200C9A66");
    private static var _customServiceControlUuid = Ble.stringToUuid("D973F2E2-B19E-11E2-9E96-0800200C9A66");

    //Controller Commands
    static const TRAINING_MODE = [ 'T' ]b;
    static const COMPETITION_MODE = [ 'C' ]b;

    function initialize() {
        registerProfiles();
    }

    static function getInstance() {
        if (instance == null) { 
            instance = new BluetoothContext();
        }
        return instance;
    }

    //Service getters
    function customService() {
        return _customServiceUuid;
    }

    function customServiceRead() {
        return _customServiceReadUuid;
    }

    function customServiceControl() {
        return _customServiceControlUuid;
    }

    private function registerProfiles() {
        var customServiceProfile = {                                                
            :uuid => _customServiceUuid,
            :characteristics => [
                {
                    :uuid => _customServiceReadUuid,
                    :descriptors => [Ble.cccdUuid()]
                }, 
                {
                    :uuid => _customServiceControlUuid,
                    :descriptors => [Ble.cccdUuid()]
                }
            ]
        };

       Ble.registerProfile( customServiceProfile );
    }

}
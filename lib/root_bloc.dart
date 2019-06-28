import 'package:device_info/device_info.dart';
import 'package:paprika_app/authentication/models/device.dart';
import 'package:paprika_app/authentication/resources/authentication_repository.dart';
import 'package:paprika_app/models/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class RootBloc implements BlocBase {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final _androidDeviceInfo = BehaviorSubject<AndroidDeviceInfo>();
  final _iosDeviceInfo = BehaviorSubject<IosDeviceInfo>();
  final _device = BehaviorSubject<Device>();
  final _darkPrimaryColor = BehaviorSubject<int>();
  final _primaryColor = BehaviorSubject<int>();
  final _secondaryColor = BehaviorSubject<int>();
  final _tertiaryColor = BehaviorSubject<int>();
  final _submitColor = BehaviorSubject<int>();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  /// Observables
  ValueObservable<Device> get device => _device.stream;

  ValueObservable<int> get darkPrimaryColor => _darkPrimaryColor.stream;

  ValueObservable<int> get primaryColor => _primaryColor.stream;

  ValueObservable<int> get secondaryColor => _secondaryColor.stream;

  ValueObservable<int> get tertiaryColor => _tertiaryColor.stream;

  ValueObservable<int> get submitColor => _submitColor.stream;

  /// Functions
  Function(Device) get changeDevice => _device.add;

  void fetchDeviceInfo(bool isAndroid) async {
    Device device;
    if (isAndroid) {
      await _deviceInfoPlugin.androidInfo.then((info) {
        _androidDeviceInfo.sink.add(info);
        device = Device(
            info.androidId,
            '',
            'Android',
            info.version.sdkInt.toString(),
            info.model,
            info.product,
            info.isPhysicalDevice.toString(),
            '',
            '',
            '',
            '',
            null);
      });
    } else {
      await _deviceInfoPlugin.iosInfo.then((info) {
        _iosDeviceInfo.sink.add(info);
        device = Device(
            info.identifierForVendor,
            '',
            'iOS',
            info.systemVersion,
            info.model,
            '',
            info.isPhysicalDevice.toString(),
            '',
            '',
            '',
            '',
            null);
      });
    }

    /// Check if we have register the device
    Device deviceExist =
        await _authenticationRepository.fetchDeviceInfo(device.id);

    /// If the device exist in the data base, we update the attributes.
    /// Otherwise, we create the device.
    if (deviceExist != null) {
      /// We take the branch office saved on the bd.
      device.branch = deviceExist.branch;
      await _authenticationRepository.updateDeviceInfo(device);
    } else {
      await _authenticationRepository.createDevice(device);
    }

    _device.sink.add(device);
  }

  void fetchColors() {
    _darkPrimaryColor.sink.add(0xFFBF360C);
    _primaryColor.sink.add(0xffff5722);
    _secondaryColor.sink.add(0xFFFFAB40);
    _tertiaryColor.sink.add(0xFFFF9800);
    _submitColor.sink.add(0xFFFF6E40);
  }

  @override
  void dispose() {
    _androidDeviceInfo.close();
    _iosDeviceInfo.close();
    _device.close();
    _darkPrimaryColor.close();
    _primaryColor.close();
    _secondaryColor.close();
    _tertiaryColor.close();
    _submitColor.close();
  }
}

final rootBloc = RootBloc();

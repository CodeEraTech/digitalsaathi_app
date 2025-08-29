
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionUtil {
  bool _isDeviceConnected = false;

  bool get isDeviceConnected => _isDeviceConnected;

  establishConnection() async{
    bool result = await InternetConnection().hasInternetAccess;
    print("djfhdjhv$result");
    _isDeviceConnected = result;
    // final listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
    //   switch (status) {
    //     case InternetStatus.connected:
    //         _isDeviceConnected = true;
    //       break;
    //     case InternetStatus.disconnected:
    //     // The internet is now disconnected
    //       _isDeviceConnected = false;
    //       break;
    //   }
    //});
  }
}
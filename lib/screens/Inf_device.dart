import 'package:device_info/device_info.dart';

class DeviceInfo {
  static Future<Map<String, String>> getDeviceInfo() async {
    Map<String, String> deviceData = {};

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (await deviceInfo.androidInfo != null) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceData['deviceId'] = androidInfo.androidId ?? 'Unknown';
      deviceData['deviceName'] = androidInfo.device ?? 'Unknown';
      deviceData['deviceModel'] = androidInfo.model ?? 'Unknown';
      deviceData['osVersion'] = androidInfo.version.release ?? 'Unknown';
    } else if (await deviceInfo.iosInfo != null) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceData['deviceId'] = iosInfo.identifierForVendor ?? 'Unknown';
      deviceData['deviceName'] = iosInfo.name ?? 'Unknown';
      deviceData['deviceModel'] = iosInfo.model ?? 'Unknown';
      deviceData['osVersion'] = iosInfo.systemVersion ?? 'Unknown';
    }

    return deviceData;
  }
}
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> requestPermission(Permission setting) async {
    // setting.request() will return the status ALWAYS
    // if setting is already requested, it will return the status
    final result = await setting.request();

    switch (result) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }

  static Future<bool> isGranted(Permission permission) async {
    switch (await permission.status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }

  static Future<PermissionStatus> getPermissionStatus(
          Permission permission) async =>
      await permission.status;
}

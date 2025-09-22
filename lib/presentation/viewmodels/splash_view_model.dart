import 'package:package_info_plus/package_info_plus.dart';

class SplashController {
  Future<(String appName, String versionLabel)> loadInfo() async {
    final info = await PackageInfo.fromPlatform();
    return (info.appName, info.version);
  }
}

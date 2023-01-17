
import 'package:cyrel_updater/platform_type.dart';
import 'package:cyrel_updater/update_downloader.dart';

import 'cyrel_updater_platform_interface.dart';

class CyrelUpdater {
  Future<bool?> installApk(String path) {
    return CyrelUpdaterPlatform.instance.installApk(path);
  }

  Future<String> download(String url, PlatformType platform, Function(double)? progressCallback) async {
    return UpdateDownloader.download(url, platform, progressCallback);
  }

  update(String url, PlatformType platform, Function(double)? progressCallback) async {
    final String path = await download(url, platform, progressCallback);
    if (platform == PlatformType.android) {
      final bool? result = await installApk(path);
      if (result == null || !result) {
        throw Error();
      }
    }
  }
}

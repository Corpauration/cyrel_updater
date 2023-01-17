import 'dart:io';

import 'package:cyrel_updater/platform_type.dart';
import 'package:path_provider/path_provider.dart';

class UpdateDownloader {
  static Future<String> download(String url, PlatformType platform, Function(double)? progressCallback) async {
    final String path = await _getPath(platform);

    final HttpClient client = HttpClient();
    final HttpClientRequest request = await client.getUrl(Uri.parse(url));
    final HttpClientResponse response = await request.close();
    final int totalSize = response.contentLength;
    int received = 0;

    await response.map((bytes) {
      received += bytes.length;
      if (progressCallback != null) {
        progressCallback(received / totalSize);
      }
      return bytes;
    }).pipe(File(path).openWrite());

    return path;
  }

  static Future<String> _getPath(PlatformType platform) async {
    switch (platform) {
      case PlatformType.android:
        return "${(await getExternalStorageDirectory())!.path}/app.apk";
      case PlatformType.windows:
        // TODO: Handle this case.
        break;
      case PlatformType.linux:
        // TODO: Handle this case.
        break;
      case PlatformType.ios:
        // TODO: Handle this case.
        break;
      case PlatformType.macos:
        // TODO: Handle this case.
        break;
    }
    return "";
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cyrel_updater_platform_interface.dart';

/// An implementation of [CyrelUpdaterPlatform] that uses method channels.
class MethodChannelCyrelUpdater extends CyrelUpdaterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cyrel_updater');

  @override
  Future<bool?> installApk(String path) async {
    final success = await methodChannel.invokeMethod<bool>('installApk', {'path': path});
    return success;
  }
}

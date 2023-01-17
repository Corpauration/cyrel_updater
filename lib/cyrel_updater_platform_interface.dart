import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cyrel_updater_method_channel.dart';

abstract class CyrelUpdaterPlatform extends PlatformInterface {
  /// Constructs a CyrelUpdaterPlatform.
  CyrelUpdaterPlatform() : super(token: _token);

  static final Object _token = Object();

  static CyrelUpdaterPlatform _instance = MethodChannelCyrelUpdater();

  /// The default instance of [CyrelUpdaterPlatform] to use.
  ///
  /// Defaults to [MethodChannelCyrelUpdater].
  static CyrelUpdaterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CyrelUpdaterPlatform] when
  /// they register themselves.
  static set instance(CyrelUpdaterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> installApk(String path) {
    throw UnimplementedError('installApk(String path) has not been implemented.');
  }
}

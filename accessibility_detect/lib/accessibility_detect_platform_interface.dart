import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'accessibility_detect_method_channel.dart';

abstract class AccessibilityDetectPlatform extends PlatformInterface {
  /// Constructs a AccessibilityDetectPlatform.
  AccessibilityDetectPlatform() : super(token: _token);

  static final Object _token = Object();

  static AccessibilityDetectPlatform _instance =
      MethodChannelAccessibilityDetect();

  /// The default instance of [AccessibilityDetectPlatform] to use.
  ///
  /// Defaults to [MethodChannelAccessibilityDetect].
  static AccessibilityDetectPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AccessibilityDetectPlatform] when
  /// they register themselves.
  static set instance(AccessibilityDetectPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPackageNameAccessibility() {
    throw UnimplementedError(
        'getPackageNameAccessibility() has not been implemented.');
  }
}

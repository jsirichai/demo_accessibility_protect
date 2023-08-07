import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'accessibility_detect_platform_interface.dart';

/// An implementation of [AccessibilityDetectPlatform] that uses method channels.
class MethodChannelAccessibilityDetect extends AccessibilityDetectPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('accessibility_detect');

  @override
  Future<String?> getPackageNameAccessibility() async {
    final version =
        await methodChannel.invokeMethod<String>('getPackageNameAccessibility');
    return version;
  }
}

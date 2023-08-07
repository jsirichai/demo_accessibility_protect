import 'accessibility_detect_platform_interface.dart';

class AccessibilityDetect {
  Future<String?> getPackageNameAccessibility() {
    return AccessibilityDetectPlatform.instance.getPackageNameAccessibility();
  }
}

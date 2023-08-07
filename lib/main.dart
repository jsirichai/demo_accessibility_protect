import 'package:flutter/material.dart';
import 'package:accessibility_detect/accessibility_detect.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

Future<void> accessibilityServiceDetector() async {
  String? packageNameAccessibilityList =
      await AccessibilityDetect().getPackageNameAccessibility();
  if (packageNameAccessibilityList != null) {
    List<dynamic> packageNameAccessibility =
        json.decode(packageNameAccessibilityList);

    List<dynamic> maliciousApplicationName = packageNameAccessibility
        .where((item) =>
            item["source"] != 'com.android.vending' &&
            item["source"] != 'com.huawei.appmarket')
        .map((item) => item["applicationName"])
        .toList();

    print(maliciousApplicationName);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Accessibility Detect'),
        ),
        body: Center(
          child: MaterialButton(
              onPressed: () {
                accessibilityServiceDetector();
              },
              color: Colors.red,
              child: const Text("Detect")),
        ),
      ),
    );
  }
}

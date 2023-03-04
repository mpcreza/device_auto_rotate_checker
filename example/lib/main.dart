import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _autoRotate = false;

  StreamSubscription? autoRotateStreamSubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      _autoRotate = await DeviceAutoRotateChecker.checkAutoRotate();
      autoRotateStreamSubscription =
          DeviceAutoRotateChecker.autoRotateStream.listen((bool autoRotate) {
        _autoRotate = autoRotate;
        setState(() {});
      });
    } on PlatformException {
      _autoRotate = false;
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device auto rotate checker'),
        ),
        body: Center(
          child: Text('Auto rotate is ${_autoRotate ? 'on' : 'off'}'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    autoRotateStreamSubscription?.cancel();
    super.dispose();
  }
}

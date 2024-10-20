import 'package:flutter/material.dart';
import 'package:pan_validation/pan_validation.dart' deferred as pan;
import 'package:aadhaar_validation/aadhaar_validation.dart' deferred as aadhaar;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Micro-App Loader',
      home: Scaffold(
        appBar: AppBar(title: const Text('Micro-App Loader')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    await loadPanMicroApp(context);
                  },
                  child: const Text('Load PAN Validation Micro-App'),
                ),
              ),
              Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    await loadAadhaarMicroApp(context);
                  },
                  child: const Text('Load Aadhaar Validation Micro-App'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadPanMicroApp(BuildContext context) async {
    await pan.loadLibrary();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pan.PanValidationScreen()),
    );
  }

  Future<void> loadAadhaarMicroApp(BuildContext context) async {
    await aadhaar.loadLibrary();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => aadhaar.AadhaarValidationScreen()),
    );
  }
}

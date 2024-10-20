import 'package:flutter/material.dart';

class AadhaarValidationScreen extends StatelessWidget {
  const AadhaarValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aadhar Validation'),
      ),
      body: const Center(
        child: Text('This is the Aadhar validation screen.'),
      ),
    );
  }
}

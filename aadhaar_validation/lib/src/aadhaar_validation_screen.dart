import 'package:flutter/material.dart';

class AadhaarValidationScreen extends StatefulWidget {
  const AadhaarValidationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AadhaarValidationScreenState createState() =>
      _AadhaarValidationScreenState();
}

class _AadhaarValidationScreenState extends State<AadhaarValidationScreen> {
  final TextEditingController _aadhaarController = TextEditingController();
  String? _validationMessage;
  bool _isAadhaarHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aadhaar Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Please enter Aadhaar card details:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _aadhaarController,
              obscureText: _isAadhaarHidden, // Hides the text when typing
              decoration: InputDecoration(
                labelText: 'Aadhaar Card',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isAadhaarHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isAadhaarHidden = !_isAadhaarHidden;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _validateAadhaar,
              child: const Text('Validate'),
            ),
            const SizedBox(height: 20.0),
            if (_validationMessage != null)
              Text(
                _validationMessage!,
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  void _validateAadhaar() {
    final aadhaar = _aadhaarController.text;

    // Simple validation for demonstration (you can enhance this logic)
    if (aadhaar.isNotEmpty && aadhaar.length == 12) {
      setState(() {
        _validationMessage = 'Aadhaar card validation successful';
      });
    } else {
      setState(() {
        _validationMessage = 'Invalid Aadhaar card details';
      });
    }
  }
}

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
    return const MaterialApp(
      title: 'Micro-App Loader',
      home: LoginScreen(),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isValidLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText:
                    !_isValidLogin ? 'Invalid username or password' : null,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText:
                    !_isValidLogin ? 'Invalid username or password' : null,
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Basic login validation logic (you can replace this with actual authentication)
    if (username == 'admin' && password == 'password') {
      // Valid login, navigate to micro-app loader
      setState(() {
        _isValidLogin = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MicroAppLoaderScreen()),
      );
    } else {
      // Invalid login
      setState(() {
        _isValidLogin = false;
      });
    }
  }
}

// Micro-App Loader Screen
class MicroAppLoaderScreen extends StatefulWidget {
  const MicroAppLoaderScreen({super.key});

  @override
  _MicroAppLoaderScreenState createState() => _MicroAppLoaderScreenState();
}

class _MicroAppLoaderScreenState extends State<MicroAppLoaderScreen> {
  bool _isLoading = false;
  String? _loadingError;

  Future<void> _loadPanMicroApp(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _loadingError = null;
    });

    try {
      await pan.loadLibrary();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pan.PanValidationScreen()),
      );
    } catch (e) {
      setState(() {
        _loadingError = 'Failed to load PAN validation app.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadAadhaarMicroApp(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _loadingError = null;
    });

    try {
      await aadhaar.loadLibrary();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => aadhaar.AadhaarValidationScreen()),
      );
    } catch (e) {
      setState(() {
        _loadingError = 'Failed to load Aadhaar validation app.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Micro-App Loader')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show loading spinner when loading
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      await _loadPanMicroApp(context);
                    },
                    child: const Text('Load PAN Validation Micro-App'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _loadAadhaarMicroApp(context);
                    },
                    child: const Text('Load Aadhaar Validation Micro-App'),
                  ),
                  const SizedBox(height: 20),
                  if (_loadingError !=
                      null) // Show error message if loading fails
                    Text(
                      _loadingError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
      ),
    );
  }
}

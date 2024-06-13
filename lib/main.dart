import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'FaceRecognitionPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BiometricHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BiometricHomePage extends StatefulWidget {
  @override
  _BiometricHomePageState createState() => _BiometricHomePageState();
}

class _BiometricHomePageState extends State<BiometricHomePage> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    print("Starting authentication");
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      print("Authentication result: $authenticated");
      if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FaceRecognitionPage()),
        );
      }
    } catch (e) {
      print("Authentication error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Authentication'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Welcome to the Biometric Authentication App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _authenticate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                child: const Text('Authenticate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

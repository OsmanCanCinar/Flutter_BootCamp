import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:flutter/material.dart';

import '../utilities/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isFirebaseInitialized
            ? ElevatedButton(
                onPressed: () async {
                  try {
                    await GoogleSignInApi.signInWithGoogle();
                    print('Log In Successful');
                    Navigator.of(context).pushReplacementNamed('/home');
                  } catch (e) {
                    print('Log In Unsuccessful');
                    print(e.toString());
                  }
                },
                child: const Text('Sign In'))
            : const CircularProgressIndicator(),
      ),
    );
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    setState(() {
      isFirebaseInitialized = true;
    });
    print('Firebase initialized');
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}

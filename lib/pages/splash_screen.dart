import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
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
                    UserCredential userCredential =
                        await GoogleSignInApi.signInWithGoogle();
                    // await GoogleSignInApi.login();
                    print('Log In Successful');
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser == null
                            ? userCredential.user?.uid
                            : FirebaseAuth.instance.currentUser!.uid)
                        .set(
                      {
                        "isLoggedIn": true,
                        "lastLoginDate": FieldValue.serverTimestamp(),
                      },
                      SetOptions(merge: true),
                    );
                    print('user added to collection Successfully');
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

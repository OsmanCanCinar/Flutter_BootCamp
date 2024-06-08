import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import '../utilities/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 200,
            height: 200,
            // child: RiveAnimation.network(
            //   'https://rive.app/community/files/10144-19383-soarus.riv',
            // ),
            child: RiveAnimation.asset(
              'animations/soarus.riv',
            ),
          ),
          SizedBox(
              width: 200,
              height: 200,
              // child: RiveAnimation.network(
              //   'https://rive.app/community/files/10144-19383-soarus.riv',
              // ),
              child: Lottie.asset('animations/Animation-1717795778489.json')),
          Center(
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
        ],
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

    // Commented out for integration test
    // if (FirebaseAuth.instance.currentUser != null) {
    //   Navigator.of(context).pushReplacementNamed('/home');
    // }
    Navigator.of(context).pushReplacementNamed('/home');
  }
}

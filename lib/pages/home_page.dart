import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/pages/messages_page.dart';
import 'package:flutter_skeleton/pages/students_page.dart';
import 'package:flutter_skeleton/pages/teachers_page.dart';
import 'package:flutter_skeleton/providers/app_providers.dart';
import 'package:flutter_skeleton/utilities/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _navigateToStudentPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const StudentsPage(title: 'Students');
    }));
  }

  void _navigateToTeacherPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const TeachersPage(
        title: 'Teachers',
      );
    }));
  }

  Future<void> _navigateToMessagePage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const MessagesPage(
        title: 'Students',
      );
    }));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    final teachersRepository = ref.watch(teachersProvider);
    final newMessageCount = ref.watch(newMessageCountProvider);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerWidget(),
            ListTile(
              title: const Text('Students'),
              onTap: () {
                Navigator.of(context).pushNamed('/students');
                //_navigateToStudentPage(context);
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                Navigator.of(context).pushNamed('/teachers');
                //_navigateToTeacherPage(context);
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                Navigator.of(context).pushNamed('/messages');
                // _navigateToMessagePage(context);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () async {
                GoogleSignInApi.signOutWithGoogle();
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Skeleton App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/students');
                  // _navigateToStudentPage(context);
                },
                child: Text("${studentsRepository.students.length} Students")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/teachers');
                  // _navigateToTeacherPage(context);
                },
                child: Text("${teachersRepository.teachers.length} Teachers")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/messages');
                  // _navigateToMessagePage(context);
                },
                child: Text("$newMessageCount Messages")),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Future<Uint8List?>? _picture;

  @override
  void initState() {
    super.initState();
    _picture = _downloadPicture();
  }

  Future<Uint8List?> _downloadPicture() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userMap = documentSnapshot.data();

    if (userMap == null) return null;

    if (userMap.containsKey('pictureRef')) {
      print("pictureRef - " + userMap['pictureRef']);
      final pictureRef = userMap['pictureRef'];
      Uint8List? uInt8list = await FirebaseStorage.instance
          .ref('pictures')
          // .child('aEQDEOWtIsbb3q1mwjbI0XLvvss1.jpg')
          .child(pictureRef.replaceAll("pictures/", ""))
          .getData();

      if (uInt8list == null) return null;
      return uInt8list;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome ${FirebaseAuth.instance.currentUser!.displayName}'),
          Text('${FirebaseAuth.instance.currentUser!.email}'),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              print('avatar tapped');
              XFile? xFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (xFile == null) return;

              final imagePath = xFile.path;
              final uid = FirebaseAuth.instance.currentUser?.uid;
              final pictureRef =
                  FirebaseStorage.instance.ref('pictures').child("$uid.jpg");

              await pictureRef.putFile(File(imagePath));

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({
                "pictureRef": pictureRef.fullPath,
              });

              setState(() {
                _picture = _downloadPicture();
              });
            },
            child: FutureBuilder<Uint8List?>(
                future: _picture,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final picture = snapshot.data!;
                    return _MovingAvatar(picture: picture);
                  } else {
                    return const CircleAvatar(
                      child: Text('OCD'),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class _MovingAvatar extends StatefulWidget {
  final Uint8List picture;

  const _MovingAvatar({super.key, required this.picture});

  @override
  State<_MovingAvatar> createState() => _MovingAvatarState();
}

class _MovingAvatarState extends State<_MovingAvatar>
    with SingleTickerProviderStateMixin<_MovingAvatar> {
  late Ticker _ticker;
  double horizontal = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      final angle = pi *
          elapsed.inMicroseconds /
          const Duration(seconds: 1).inMicroseconds;
      setState(() {
        horizontal = sin(angle) * 30 + 30;
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: horizontal),
      child: CircleAvatar(
        backgroundImage: MemoryImage(widget.picture),
      ),
    );
  }
}

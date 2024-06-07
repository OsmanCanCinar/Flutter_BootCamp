import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/providers/app_providers.dart';
import 'package:flutter_skeleton/pages/messages_page.dart';
import 'package:flutter_skeleton/pages/students_page.dart';
import 'package:flutter_skeleton/pages/teachers_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  'Welcome ${FirebaseAuth.instance.currentUser!.displayName!}'),
            ),
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
                signOutWithGoogle();
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

  Future<void> signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}

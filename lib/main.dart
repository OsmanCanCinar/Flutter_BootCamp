import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/pages/messages_page.dart';
import 'package:flutter_skeleton/pages/students_page.dart';
import 'package:flutter_skeleton/pages/teachers_page.dart';
import 'package:flutter_skeleton/providers/app_providers.dart';

void main() {
  runApp(const ProviderScope(child: SkeletonApp()));
}

class SkeletonApp extends StatelessWidget {
  const SkeletonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const HomePage(),
      //   '/students': (context) => const StudentsPage(title: 'Students'),
      //   '/teachers': (context) => const TeachersPage(title: 'Teachers'),
      //   '/messages': (context) => const MessagesPage(title: 'Messages'),
      // },
    );
  }
}

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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Welcome Can'),
            ),
            ListTile(
              title: const Text('Students'),
              onTap: () {
                // Navigator.of(context).pushNamed('/students');
                _navigateToStudentPage(context);
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                // Navigator.of(context).pushNamed('/teachers');
                _navigateToTeacherPage(context);
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                // Navigator.of(context).pushNamed('/messages');
                _navigateToMessagePage(context);
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
                  // Navigator.of(context).pushNamed('/students');
                  _navigateToStudentPage(context);
                },
                child: Text("${studentsRepository.students.length} Students")),
            TextButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('/teachers');
                  _navigateToTeacherPage(context);
                },
                child: Text("${teachersRepository.teachers.length} Teachers")),
            TextButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('/messages');
                  _navigateToMessagePage(context);
                },
                child: Text("$newMessageCount Messages")),
          ],
        ),
      ),
    );
  }
}

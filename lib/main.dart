import 'package:flutter/material.dart';
import 'package:flutter_skeleton/pages/messages_page.dart';
import 'package:flutter_skeleton/pages/students_page.dart';
import 'package:flutter_skeleton/pages/teachers_page.dart';
import 'package:flutter_skeleton/repositories/messages_repository.dart';
import 'package:flutter_skeleton/repositories/students_repository.dart';
import 'package:flutter_skeleton/repositories/teachers_repository.dart';

void main() {
  runApp(const SkeletonApp());
}

class SkeletonApp extends StatelessWidget {
  const SkeletonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton App',
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MessagesRepository messagesRepository = MessagesRepository();
  StudentsRepository studentsRepository = StudentsRepository();
  TeachersRepository teachersRepository = TeachersRepository();

  void _navigateToStudentPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return StudentsPage(
        title: 'Students',
        repository: studentsRepository,
      );
    }));
  }

  void _navigateToTeacherPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TeachersPage(
        title: 'Teachers',
        repository: teachersRepository,
      );
    }));
  }

  void _navigateToMessagePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MessagesPage(
        title: 'Students',
        repository: messagesRepository,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text("${messagesRepository.messages.length} Messages")),
          ],
        ),
      ),
    );
  }
}

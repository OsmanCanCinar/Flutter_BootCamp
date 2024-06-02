import 'package:flutter/material.dart';
import 'package:flutter_skeleton/pages/messages_page.dart';
import 'package:flutter_skeleton/pages/students_page.dart';
import 'package:flutter_skeleton/pages/teachers_page.dart';

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
        //home: const HomePage(title: 'Skeleton App Home Page'),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(title: 'Skeleton App Home Page'),
          '/students': (context) => const StudentsPage(title: 'Students'),
          '/teachers': (context) => const TeachersPage(title: 'Teachers'),
          '/messages': (context) => const MessagesPage(title: 'Messages'),
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

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
                Navigator.of(context).pushNamed('/students');
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                Navigator.of(context).pushNamed('/teachers');
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                Navigator.of(context).pushNamed('/messages');
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
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/students');
                },
                child: const Text('Students')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/teachers');
                },
                child: const Text('Teachers')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/messages');
                },
                child: const Text('Messages')),
          ],
        ),
      ),
    );
  }
}

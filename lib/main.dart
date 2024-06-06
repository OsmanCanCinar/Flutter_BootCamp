import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/pages/home_page.dart';
import 'package:flutter_skeleton/pages/messages_page.dart';
import 'package:flutter_skeleton/pages/new_teacher_page.dart';
import 'package:flutter_skeleton/pages/splash_screen.dart';
import 'package:flutter_skeleton/pages/students_page.dart';
import 'package:flutter_skeleton/pages/teachers_page.dart';


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
      // home: const HomePage(),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const HomePage(),
        '/splash': (context) => const SplashScreen(),
        '/students': (context) => const StudentsPage(title: 'Students'),
        '/teachers': (context) => const TeachersPage(title: 'Teachers'),
        '/messages': (context) => const MessagesPage(title: 'Messages'),
        '/newTeacher': (context) => const NewTeacherPage(title: 'Add Teacher'),
      },
    );
  }
}


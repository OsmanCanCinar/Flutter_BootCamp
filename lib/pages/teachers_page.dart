import 'package:flutter/material.dart';

class TeachersPage extends StatefulWidget {
  final String title;

  const TeachersPage({super.key, required this.title});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 4,
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                  child: Text(
                    '25 Teachers',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

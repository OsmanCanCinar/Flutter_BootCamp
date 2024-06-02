import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  final String title;

  const MessagesPage({super.key, required this.title});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
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
                    '25 Messages',
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

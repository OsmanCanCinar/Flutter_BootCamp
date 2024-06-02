import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  final String title;

  const StudentsPage({super.key, required this.title});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PhysicalModel(
              color: Colors.white,
              elevation: 4,
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                  child: Text(
                    '25 Students',
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: const Text('👨🏻‍🦱 👩🏻'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                  title: const Text('Can'),
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

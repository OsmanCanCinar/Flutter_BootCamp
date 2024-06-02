import 'package:flutter/material.dart';
import 'package:flutter_skeleton/repositories/teachers_repository.dart';

class TeachersPage extends StatefulWidget {
  final String title;
  final TeachersRepository repository;

  const TeachersPage(
      {super.key, required this.title, required this.repository});

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
                    '25 Teachers',
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

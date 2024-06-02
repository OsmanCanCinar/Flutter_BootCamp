import 'package:flutter/material.dart';
import 'package:flutter_skeleton/models/teacher.dart';
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
            PhysicalModel(
              color: Colors.white,
              elevation: 4,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 32.0),
                  child: Text(
                    "${widget.repository.teachers.length} Teachers",
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    TeacherRow(teacher: widget.repository.teachers[index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherRow extends StatefulWidget {
  final Teacher teacher;

  const TeacherRow({
    super.key,
    required this.teacher,
  });

  @override
  State<TeacherRow> createState() => _TeacherRowState();
}

class _TeacherRowState extends State<TeacherRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IntrinsicWidth(
          child: Center(
              child: Text(widget.teacher.gender == 'male' ? '👨🏻‍' : '👩🏻'))),
      title: Text('${widget.teacher.name} ${widget.teacher.surname}'),
    );
  }
}

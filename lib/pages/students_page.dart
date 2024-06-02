import 'package:flutter/material.dart';
import 'package:flutter_skeleton/models/student.dart';
import 'package:flutter_skeleton/repositories/students_repository.dart';

class StudentsPage extends StatefulWidget {
  final String title;
  final StudentsRepository repository;

  const StudentsPage({
    super.key,
    required this.title,
    required this.repository,
  });

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
            PhysicalModel(
              color: Colors.white,
              elevation: 4,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 32.0),
                  child: Text(
                    "${widget.repository.students.length} Students",
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => StudentRow(
                  student: widget.repository.students[index],
                  repository: widget.repository,
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.repository.students.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentRow extends StatefulWidget {
  final Student student;
  final StudentsRepository repository;

  const StudentRow({
    super.key,
    required this.student,
    required this.repository,
  });

  @override
  State<StudentRow> createState() => _StudentRowState();
}

class _StudentRowState extends State<StudentRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IntrinsicWidth(
          child: Center(
              child: Text(widget.student.gender == 'male' ? '👨🏻‍' : '👩🏻'))),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            if (widget.repository.isLiked(widget.student)) {
              widget.repository.dislike(widget.student);
            } else {
              widget.repository.like(widget.student);
            }
          });
        },
        icon: Icon(widget.repository.isLiked(widget.student)
            ? Icons.favorite
            : Icons.favorite_border),
      ),
      title: Text('${widget.student.name} ${widget.student.surname}'),
    );
  }
}

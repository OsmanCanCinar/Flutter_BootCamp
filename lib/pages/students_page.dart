import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/models/student.dart';
import 'package:flutter_skeleton/repositories/students_repository.dart';

class StudentsPage extends ConsumerWidget {
  final String title;

  const StudentsPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(studentsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
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
                    "${repository.students.length} Students",
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    StudentRow(student: repository.students[index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: repository.students.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentRow extends ConsumerWidget {
  final Student student;

  const StudentRow({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(studentsProvider);
    return ListTile(
      leading: IntrinsicWidth(
          child:
              Center(child: Text(student.gender == 'male' ? '👨🏻‍' : '👩🏻'))),
      trailing: IconButton(
        onPressed: () {
          final localRepository = ref.read(studentsProvider);
          if (localRepository.isLiked(student)) {
            localRepository.dislike(student);
          } else {
            localRepository.like(student);
          }
        },
        icon: Icon(repository.isLiked(student)
            ? Icons.favorite
            : Icons.favorite_border),
      ),
      title: Text('${student.name} ${student.surname}'),
    );
  }
}

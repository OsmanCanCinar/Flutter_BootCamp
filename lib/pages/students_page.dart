import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/models/student.dart';

import '../providers/app_providers.dart';

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
                    // StudentRow(student: repository.students[index]),
                    StudentRowForTest(
                  student: repository.students[index],
                  isAnimated: false,
                  // isAnimated: true,
                ),
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
        icon: AnimatedCrossFade(
          firstChild: const Icon(Icons.favorite),
          secondChild: const Icon(Icons.favorite_border),
          crossFadeState: repository.isLiked(student)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(seconds: 1),
        ),
      ),
      title: AnimatedPadding(
        curve: Curves.bounceOut,
        padding: repository.isLiked(student)
            ? const EdgeInsets.only(left: 48.0)
            : EdgeInsets.zero,
        duration: const Duration(seconds: 1),
        child: Text('${student.name} ${student.surname}'),
      ),
    );
  }
}

class StudentRowForTest extends ConsumerWidget {
  final Student student;
  final bool isAnimated;

  const StudentRowForTest({
    super.key,
    this.isAnimated = true,
    required this.student,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudentRowBasicForTest(
      onPressed: (bool isLiked) {
        ref.read(studentsProvider).isLiked(student);
      },
      isLiked: ref.watch(studentsProvider).isLiked(student),
      student: student,
      isAnimated: isAnimated,
    );
  }
}

class StudentRowBasicForTest extends StatefulWidget {
  final bool isLiked;
  final bool isAnimated;
  final Student student;
  final void Function(bool isLiked) onPressed;

  const StudentRowBasicForTest({
    super.key,
    required this.isLiked,
    required this.student,
    required this.onPressed,
    this.isAnimated = true,
  });

  @override
  State<StudentRowBasicForTest> createState() => _StudentRowBasicForTestState();
}

class _StudentRowBasicForTestState extends State<StudentRowBasicForTest> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.isAnimated
          ? AnimatedPadding(
              duration: const Duration(seconds: 1),
              padding:
                  isLiked ? const EdgeInsets.only(left: 48.0) : EdgeInsets.zero,
              curve: Curves.bounceOut,
              child: Text('${widget.student.name} ${widget.student.surname}'),
            )
          : Padding(
              padding:
                  isLiked ? const EdgeInsets.only(left: 48.0) : EdgeInsets.zero,
              child: Text('${widget.student.name} ${widget.student.surname}'),
            ),
      leading: IntrinsicWidth(
          child: Center(
              child: Text(widget.student.gender == 'male' ? '👨🏻‍' : '👩🏻'))),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            isLiked = !isLiked;
          });
          widget.onPressed(isLiked);
        },
        icon: buildIcon(),
      ),
    );
  }

  Widget buildIcon() {
    if (widget.isAnimated) {
      return AnimatedCrossFade(
        firstChild: const Icon(Icons.favorite),
        secondChild: const Icon(Icons.favorite_border),
        crossFadeState:
            isLiked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(seconds: 1),
      );
    } else {
      return isLiked
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border);
    }
  }
}

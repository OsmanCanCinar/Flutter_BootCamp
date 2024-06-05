import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/models/teacher.dart';

import '../providers/app_providers.dart';

class TeachersPage extends ConsumerWidget {
  final String title;

  const TeachersPage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(teachersProvider);

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
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 32.0),
                      child: Text(
                        "${repository.teachers.length} Teachers",
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: DownloadButton(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    TeacherRow(teacher: repository.teachers[index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: repository.teachers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    super.key,
  });

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return isLoading
          ? const CircularProgressIndicator()
          : IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await ref.read(teachersProvider).download();
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            );
    });
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

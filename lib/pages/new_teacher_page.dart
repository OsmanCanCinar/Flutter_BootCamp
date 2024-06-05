import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/providers/app_providers.dart';

import '../models/teacher.dart';

class NewTeacherPage extends ConsumerStatefulWidget {
  final String title;

  const NewTeacherPage({super.key, required this.title});

  @override
  ConsumerState<NewTeacherPage> createState() => _NewTeacherPageState();
}

class _NewTeacherPageState extends ConsumerState<NewTeacherPage> {
  final Map<String, dynamic> entries = {};
  final _formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w300,
            fontSize: 22),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "This field is required";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    entries['name'] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Surname'),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "This field is required";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    entries['surname'] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Age'),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "This field is required";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    entries['age'] = int.parse(newValue!);
                  },
                ),
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      value: "male",
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: "female",
                      child: Text('Female'),
                    )
                  ],
                  value: entries['gender'],
                  onChanged: (value) {
                    setState(() {
                      entries['gender'] = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Choose gender";
                    }
                    return null;
                  },
                ),
                isSaving
                    ? Center(child: const CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          final formSate = _formKey.currentState;
                          if (formSate == null) return;

                          if (formSate.validate() == true) {
                            formSate.save();
                            print(entries);
                          }

                          try {
                            setState(() {
                              isSaving = true;
                            });

                            await ref
                                .read(networkServiceProvider)
                                .addTeacher(Teacher.fromMap(entries));
                            Navigator.of(context).pop();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          } finally {
                            setState(() {
                              isSaving = false;
                            });
                          }
                        },
                        child: const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

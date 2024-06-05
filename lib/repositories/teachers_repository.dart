import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/models/teacher.dart';

class TeachersRepository extends ChangeNotifier {
  final List<Teacher> teachers = [
    Teacher(name: 'John', surname: 'Doe', age: 21, gender: 'male'),
    Teacher(name: 'Kate', surname: 'Wild', age: 20, gender: 'female'),
  ];

  void download() {
    const jsonBody = """{
      'name': 'Jane',
      'surname': 'Doe',
      'age': 27,
      'gender': 'female',
    }""";

    final decodedMap = jsonDecode(jsonBody);

    final teacher = Teacher.fromMap(decodedMap);
    teachers.add(teacher);
    notifyListeners();
  }
}

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository();
});

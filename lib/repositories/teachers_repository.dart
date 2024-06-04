import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/models/teacher.dart';

class TeachersRepository extends ChangeNotifier {
  final List<Teacher> teachers = [
    Teacher(name: 'John', surname: 'Doe', age: 21, gender: 'male'),
    Teacher(name: 'Kate', surname: 'Wild', age: 20, gender: 'female'),
  ];
}

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository();
});

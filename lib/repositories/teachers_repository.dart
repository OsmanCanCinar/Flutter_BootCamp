import 'package:flutter_skeleton/models/teacher.dart';

class TeachersRepository {
  final List<Teacher> teachers = [
    Teacher(name: 'John', surname: 'Doe', age: 21, gender: 'male'),
    Teacher(name: 'Kate', surname: 'Wild', age: 20, gender: 'female'),
  ];
}

import 'package:flutter_skeleton/models/student.dart';

class StudentsRepository {
  final List<Student> students = [
    Student(name: 'John', surname: 'Doe', age: 21, gender: 'male'),
    Student(name: 'Kate', surname: 'Wild', age: 20, gender: 'female'),
  ];
}

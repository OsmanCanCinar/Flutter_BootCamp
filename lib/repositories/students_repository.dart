import 'package:flutter_skeleton/models/student.dart';

class StudentsRepository {
  final List<Student> students = [
    Student(name: 'John', surname: 'Doe', age: 21, gender: 'male'),
    Student(name: 'Kate', surname: 'Wild', age: 20, gender: 'female'),
  ];

  final Set<Student> likedStudents = {};

  void like(Student student) {
    likedStudents.add(student);
  }

  void dislike(Student student) {
    likedStudents.remove(student);
  }

  bool isLiked(Student student) {
    return likedStudents.contains(student);
  }
}

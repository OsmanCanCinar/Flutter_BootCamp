import 'package:flutter_skeleton/models/student.dart';
import 'package:flutter_skeleton/repositories/students_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Student liking', () {
    test('If the liked student displayed as liked', () {
      final studentRepository = StudentsRepository();
      final student =
      Student(name: 'John', surname: 'Doe', age: 21, gender: 'male');

      studentRepository.students.add(student);
      expect(studentRepository.isLiked(student), false);

      studentRepository.like(student);
      expect(studentRepository.isLiked(student), true);

      studentRepository.dislike(student);
      expect(studentRepository.isLiked(student), false);

      // it will catch it
      // expect(studentRepository.isLiked(student), true);
    });

    test('Unknow student liking', () {
      final studentRepository = StudentsRepository();
      final student =
      Student(name: 'John', surname: 'Doe', age: 21, gender: 'male');
      expect(studentRepository.isLiked(student), false);
    });
  });
}

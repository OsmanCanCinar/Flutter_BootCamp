import 'package:flutter/widgets.dart';
import 'package:flutter_skeleton/models/teacher.dart';
import 'package:flutter_skeleton/services/network_service.dart';

class TeachersRepository extends ChangeNotifier {
  final List<Teacher> teachers = [
    Teacher(name: 'John', surname: 'Doe', age: 21, gender: 'male'),
    Teacher(name: 'Kate', surname: 'Wild', age: 20, gender: 'female'),
  ];

  final NetworkService networkService;

  TeachersRepository(this.networkService);

  Future<void> download() async {
    Teacher teacher = await networkService.getNewTeacher();
    teachers.add(teacher);
    notifyListeners();
  }
}

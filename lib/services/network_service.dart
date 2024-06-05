import 'dart:convert';

import 'package:flutter_skeleton/models/teacher.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final String baseUrl = "https://666021e15425580055b25c6f.mockapi.io/";

  Future<Teacher> getNewTeacher() async {
    final response = await http.get(Uri.parse('${baseUrl}teachers/teachers/1'));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Download Failed with ${response.statusCode} error code');
    }
  }

//https://raw.githubusercontent.com/OsmanCanCinar/Placeholder_JSON/main/mock.json
}

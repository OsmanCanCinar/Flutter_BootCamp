import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_skeleton/models/teacher.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final String baseUrl = "https://666021e15425580055b25c6f.mockapi.io/";

  // int retryCount = 0;

  Future<Teacher> getNewTeacher() async {
    final response = await http.get(Uri.parse('${baseUrl}teachers/teachers/1'));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Download Failed with ${response.statusCode} error code');
    }
  }

  Future<void> addTeacher(Teacher teacher) async {
    await FirebaseFirestore.instance
        .collection('teachers')
        .add(teacher.toMap());

    // final response = await http.post(
    //   Uri.parse("${baseUrl}teachers/teachers"),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(teacher.toMap()),
    // );
    //
    //
    // if (response.statusCode == 201) {
    //   return;
    // } else {
    //   throw Exception(
    //       'Post Request Failed with ${response.statusCode} error code');
    // }
  }

  Future<List<Teacher>> getAllTeachers() async {
    // final response = await http.get(Uri.parse('${baseUrl}teachers/teachers'));
    // retryCount++;
    // if (response.statusCode == 200) {
    // if (response.statusCode == (retryCount < 4 ? 100 : 200)) {
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   return data.map<Teacher>((e) => Teacher.fromMap(e)).toList();
    // } else {
    //   throw Exception('Download Failed with ${response.statusCode} error code');
    // }
    final querySnapshot =
        await FirebaseFirestore.instance.collection('teachers').get();
    return querySnapshot.docs.map((e) => Teacher.fromMap(e.data())).toList();
  }

//https://raw.githubusercontent.com/OsmanCanCinar/Placeholder_JSON/main/mock.json
}

class Teacher {
  String name;
  String surname;
  int age;
  String gender;

  Teacher(
      {required this.name,
      required this.surname,
      required this.age,
      required this.gender});

  Teacher.fromMap(Map<String, dynamic> m)
      : this(
            name: m['name'],
            surname: m['surname'],
            age: m['age'],
            gender: m['gender']);
}

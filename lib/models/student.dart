class Student {
  String name;
  String surname;
  int age;
  String gender;

  Student(
      {required this.name,
      required this.surname,
      required this.age,
      required this.gender});

  Student.fromMap(Map<String, dynamic> m)
      : this(
            name: m['name'],
            surname: m['surname'],
            age: m['age'],
            gender: m['gender']);
}

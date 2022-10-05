// ignore: camel_case_types
class CoursesLists {
  // ignore: non_constant_identifier_names
  final String course_name;

  const CoursesLists({
    // ignore: non_constant_identifier_names
    required this.course_name,
  });

  static CoursesLists fromJson(json) =>
      CoursesLists(course_name: json['course_name']);
}

// ignore: camel_case_types
class CoursesLists {
  // ignore: non_constant_identifier_names
  final String course_name;
  final String course_description;

  const CoursesLists({
    // ignore: non_constant_identifier_names
    required this.course_name,
    required this.course_description,
  });

  static CoursesLists fromJson(json) => CoursesLists(
      course_name: json['course_name'],
      course_description: json['course_description']);
}

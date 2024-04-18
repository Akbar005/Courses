import 'package:courses_app/repositories/course_repository.dart';

abstract class Repository {
  factory Repository() => CourseRepository();

  Future<dynamic> login({required String email, required String password});
  Future<dynamic> getCourse({required String limit});
}

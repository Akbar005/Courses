import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:courses_app/networking/api_exception.dart';
import 'package:courses_app/repositories/repository.dart';
import 'package:courses_app/utils/constant_strings.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;

class CourseRepository implements Repository {
  final firebaseUrl = 'us-central1-chatapp-e97a6.cloudfunctions.net';
  final courseUrl = 'fakestoreapi.com';
  final _login = '/TODO/login';
  final _courses = '/products';

  @override
  Future<dynamic> login(
      {required String email, required String password}) async {
    var jsonMap = <String, dynamic>{
      'email': email,
      'password': password,
    };
    var jsonString = json.encode(jsonMap);
    dynamic responseJson;
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      final response = await http.post(Uri.https(firebaseUrl, _login),
          body: jsonString, headers: header);

      responseJson = utf8.decode(response.bodyBytes);
    } on Exception {
      throw FetchDataException(ConstantStrings.someErrorOccurred);
    }
    return responseJson;
  }

  @override
  Future<dynamic> getCourse({required String limit}) async {
    var jsonMap = <String, dynamic>{'limit': limit};

    dynamic responseJson;

    var uri = Uri.https(courseUrl, _courses, jsonMap);
    var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      var r = const RetryOptions(maxAttempts: 5);
      final response = await r.retry(
        () =>
            http.get(uri, headers: header).timeout(const Duration(seconds: 10)),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      responseJson = _returnResponse(response);

      return responseJson;
    } on Exception {
      throw FetchDataException(ConstantStrings.someErrorOccurred);
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error: ${response.statusCode}');
    }
  }
}

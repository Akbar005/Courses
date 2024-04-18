import 'dart:convert';

import 'package:courses_app/models/user.dart';
import 'package:courses_app/repositories/repository.dart';
import 'package:courses_app/screens/home.dart';
import 'package:courses_app/utils/constant_strings.dart';
import 'package:courses_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  late Repository _repository;
  final SnackBarWidget _snackBarWidget = SnackBarWidget();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late User user;

  LoginProvider() {
    _repository = Repository();
  }

  void login(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var loginResponse =
          await _repository.login(email: email, password: password);
      var json = jsonDecode(loginResponse);
      if (json['status'] == 'success') {
        if (json['data'] != null && json['data'].isNotEmpty) {
          user = User.fromJson(json['data'].first);
          prefs.setString("userId", user.id);
          prefs.setString("name", user.name);
          prefs.setString("email", user.email);
        }
        _isLoading = false;
        notifyListeners();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        // print(json);
        _snackBarWidget.snackBar(context, json["message"], false);
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      // print(e.toString());
      _snackBarWidget.snackBar(
          context, ConstantStrings.someErrorOccurred, false);
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:courses_app/models/course.dart';
import 'package:courses_app/repositories/repository.dart';
import 'package:courses_app/utils/constant_strings.dart';
import 'package:courses_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  late Repository _repository;
  final SnackBarWidget _snackBarWidget = SnackBarWidget();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Course> crsList = [];
  int callCount = 1;

  HomeProvider() {
    _repository = Repository();
  }

  getCourse(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      callCount++;
      var response =
          await _repository.getCourse(limit: (5 * callCount).toString());
      var json = response;
      if (json.isNotEmpty) {
        crsList = [];
        Iterable data = json;
        crsList.addAll(data.map((e) => Course.fromJson(e)).toList());
        _isLoading = false;
        notifyListeners();
      } else {
        // print(json);
        _snackBarWidget.snackBar(
            context, ConstantStrings.someErrorOccurred, false);
        _isLoading = false;
        notifyListeners();
      }
    } catch (ex) {
      // print(ex.toString());
      _snackBarWidget.snackBar(
          context, ConstantStrings.someErrorOccurred, false);
      _isLoading = false;
      notifyListeners();
    }
  }
}

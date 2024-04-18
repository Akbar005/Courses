import 'package:courses_app/provider/home_provider.dart';
import 'package:courses_app/provider/login_provider.dart';
import 'package:courses_app/screens/login.dart';
import 'package:courses_app/services/locator_service.dart';
import 'package:courses_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider()),
          ChangeNotifierProvider<HomeProvider>(
              create: (context) => HomeProvider()),
        ],
        child: MaterialApp(
          title: 'Courses App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(245, 249, 250, 100)),
            useMaterial3: true,
          ),
          navigatorKey: locator<NavigationService>().navigatorKey,
          home: const LoginScreen(),
        ));
  }
}

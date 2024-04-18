import 'package:courses_app/models/course.dart';
import 'package:courses_app/provider/home_provider.dart';
import 'package:courses_app/screens/login.dart';
import 'package:courses_app/widgets/app_text_field.dart';
import 'package:courses_app/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Course> crsList = [];
  final TextEditingController _srchTextEditingController =
      TextEditingController(text: '');
  late SharedPreferences _pref;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData(true);
    });

    super.initState();
    _controller.addListener(_scrollListener);
  }

  getData(bool firstCall) async {
    if (firstCall) {
      _pref = await SharedPreferences.getInstance();
    }
    Provider.of<HomeProvider>(context, listen: false).getCourse(context);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      getData(false);
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('You want to Logout'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  _pref.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      if (_srchTextEditingController.text.length < 2) {
        crsList = homeProvider.crsList;
      }

      return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: const Color(0xffF5F9FA),
            appBar: AppBar(
              title: const Text("academy"),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _onWillPop();
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                    controller: _srchTextEditingController,
                    labelText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    fillColor: Colors.white,
                    onChange: (txt) {
                      onChanged(homeProvider, txt);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Showing ${crsList.length} Courses",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                        controller: _controller,
                        itemBuilder: (context, index) {
                          if (index == crsList.length - 1 &&
                              _srchTextEditingController.text == "") {
                            if (homeProvider.callCount <=
                                (crsList.length / 5)) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }
                          return CourseCard(
                            course: crsList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: crsList.length),
                  )
                ],
              ),
            ),
          ));
    });
  }

  onChanged(HomeProvider homeProvider, String txt) {
    crsList = [];
    crsList = homeProvider.crsList
        .where((e) => e.title.toLowerCase().contains(txt.toLowerCase()))
        .toList();
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quotes_app/controller/dependency_injection.dart';
import 'package:quotes_app/pages/home.dart';
import 'package:quotes_app/pages/loading.dart';

void main() {
  DependencyInjection.init();
  runApp(GetMaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
    },
  ));
}
Widget loadingBuilder(BuildContext context) => Loading();

Widget homeBuilder(BuildContext context) => Home();


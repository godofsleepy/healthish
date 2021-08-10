import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthish/core/common/locator/locator.dart';
import 'package:healthish/core/common/route/route_generate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setuplocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthish',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerate.generateRoute,
    );
  }
}

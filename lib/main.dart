import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/displayPage.dart';

void main() async {
  // initialize the hive
  await Hive.initFlutter();

  // open the box
  var _box = await Hive.openBox("my_box");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DislayPage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
    );
  }
}

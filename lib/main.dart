import 'package:examquestion/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('studentsBox');
  runApp( MyWidget());
 }
 class MyWidget extends StatelessWidget {   
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
 }
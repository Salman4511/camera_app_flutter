
import 'package:flutter/material.dart';
import 'package:flutter_cam_app/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 95, 74, 133)),
        useMaterial3: true,
      ),
      home: const homescreen(),
    );
  }
}



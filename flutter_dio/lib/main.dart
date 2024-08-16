import 'package:flutter/material.dart';
import 'package:flutter_dio/common/manager/route_manager.dart';
import 'package:flutter_dio/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      home: HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_provider/common/manager/route_manager.dart';
import 'package:flutter_provider/provider/note_provider.dart';
import 'package:flutter_provider/views/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider()..init(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        home: HomeScreen(),
      ),
    );
  }
}

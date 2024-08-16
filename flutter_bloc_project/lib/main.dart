import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/database_helper.dart';
import 'package:flutter_bloc_project/common/manager/route_manager.dart';
import 'package:flutter_bloc_project/cubit/note_cubit.dart';
import 'package:flutter_bloc_project/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  runApp(BlocProvider(
    create: (_) => NoteCubit(
      databaseHelper,
    ),
    child: const MyApp(),
  ));
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

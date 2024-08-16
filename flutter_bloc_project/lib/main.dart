import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/core/manager/route_manager.dart';
import 'package:flutter_bloc_project/cubit/note_cubit.dart';
import 'package:flutter_bloc_project/init_dependencies.dart';
import 'package:flutter_bloc_project/presentation/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();

  runApp(BlocProvider(
    create: (_) => getIt<NoteCubit>(),
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

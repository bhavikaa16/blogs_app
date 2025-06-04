import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_bloc/UserListScreen.dart';
import 'package:proj_bloc/post/post_bloc.dart';
import 'package:proj_bloc/post_screen.dart';
import 'package:proj_bloc/theme_cubit.dart';
import 'package:proj_bloc/todo/todo_bloc.dart';
import 'package:proj_bloc/user/user_bloc.dart';
import 'package:proj_bloc/user_detail_screen.dart';
import 'package:proj_bloc/user_repository.dart';

import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(create: (_)=>UserRepository(),
    child:
    MultiBlocProvider(
      providers: [BlocProvider(create: (context)=>UserBloc(context.read<UserRepository>())),
        BlocProvider(create: (context) => PostBloc(context.read<UserRepository>())),
        BlocProvider(create: (context) => TodoBloc(context.read<UserRepository>())),
        BlocProvider(create: (_) => ThemeCubit()),],

      child:BlocBuilder<ThemeCubit, ThemeMode>(
    builder: (context, themeMode) {
      final ThemeData _lightTheme = ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Color(0xFFF3F4F6),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.deepPurple,
        ),
      );

       return MaterialApp(
      title: 'Flutter Demo',
      theme: _lightTheme,
    darkTheme: ThemeData.dark(),
    themeMode: themeMode,
    home: const Userlistscreen(),
    onGenerateRoute: (settings) {
    if (settings.name == '/user-detail') {
    final user = settings.arguments as User;
    return MaterialPageRoute(builder: (_) => UserDetailScreen(user: user));
    } else if (settings.name == '/create-post') {
    final user = settings.arguments as User;
    return MaterialPageRoute(builder: (_) => PostScreen(user: user));
    }
    return MaterialPageRoute(
        builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Page Not Found")),
      body: const Center(child: Text("Route does not exist")),   )
    );}

    );

    })));}}

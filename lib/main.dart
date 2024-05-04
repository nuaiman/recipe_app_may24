import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/features/recipes/screens/home_screen.dart';

import 'core/constants/palette.dart';

void main() {
  runApp(const ProviderScope(child: RecipesApp()));
}

class RecipesApp extends StatelessWidget {
  const RecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          fontFamily: 'Quicksand',
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Palette.white,
            surfaceTintColor: Palette.white,
          ),
          scaffoldBackgroundColor: const Color(0xFFF9F9F9)),
      home: const HomeScreen(),
    );
  }
}

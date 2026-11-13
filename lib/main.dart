import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AppBitacora());
}

class AppBitacora extends StatelessWidget {
  const AppBitacora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Funciones Nativas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
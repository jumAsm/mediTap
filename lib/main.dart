import 'package:flutter/material.dart';
import 'Pages/HomeScreen.dart';

void main() {
  runApp(const KidneyCareApp());
}

class KidneyCareApp extends StatelessWidget {
  const KidneyCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kidney Care AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D62ED)),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // استدعاء الشاشة من الملف المنفصل
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/MedicineBloc.dart';

import 'Pages/HomeScreen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => MedicineBloc(),
      child: const KidneyCareApp(),
    ),
  );
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
      home: const HomeScreen(),
    );
  }
}

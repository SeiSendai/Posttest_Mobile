import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const HeartPulseApp());
}

class HeartPulseApp extends StatelessWidget {
  const HeartPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vital Heart Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE53935),
        ),
      ),
      home: const HeartHomePage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/heart_provider.dart';
import 'pages/heart_home_page.dart';

void main() {
  runApp(
    // Tempat mendaftarkan beberapa provider yang dibutuhkan aplikasi
    MultiProvider(
      providers: [
        // Membuat dan menyediakan instance HeartProvider ke seluruh widget dibawahnya
        ChangeNotifierProvider(create: (_) => HeartProvider()),
      ],
      child: const HeartPulseApp(),
    ),
  );
}

// Widget wrapper utama dari aplikasi
class HeartPulseApp extends StatelessWidget {
  const HeartPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vital Heart Monitor',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
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
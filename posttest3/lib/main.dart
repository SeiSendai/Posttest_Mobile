import 'package:flutter/material.dart';
import 'models/heart_log.dart';
import 'pages/heart_home_page.dart';

void main() {
  runApp(const HeartPulseApp());
}

class HeartPulseApp extends StatefulWidget {
  const HeartPulseApp({super.key});

  @override
  State<HeartPulseApp> createState() => _HeartPulseAppState();
}

class _HeartPulseAppState extends State<HeartPulseApp> {
  // daftar riwayat detak jantung
  List<HeartLog> logs = [
    HeartLog(
      id: '1',
      bpm: 78,
      status: 'Normal',
      category: 'Istirahat',
      time: 'Hari ini, 08:30 WITA',
    ),
    HeartLog(
      id: '2',
      bpm: 115,
      status: 'Tinggi',
      category: 'Olahraga',
      time: 'Kemarin, 17:15 WITA',
    ),
  ];

  // target BPM
  int targetBpm = 80;

  // fungsi menambah log riwayat baru
  void addLog(HeartLog newLog) {
    setState(() {
      logs.insert(0, newLog);
    });
  }

  // fungsi mengubah bpm harian
  void updateTargetBpm(int newTarget) {
    setState(() {
      targetBpm = newTarget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vital Heart Monitor',
      debugShowCheckedModeBanner: false, // mnghilangkan banner debug
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE53935),
        ),
      ),
      home: HeartHomePage(
        logs: logs,
        targetBpm: targetBpm,
        onAddLog: addLog,
        onUpdateTargetBpm: updateTargetBpm,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/heart_log.dart';

// Kelas Flutter yang berfungsi menyediakan mekanisme notifikasi perubahan state
class HeartProvider extends ChangeNotifier {
  final List<HeartLog> _logs = [
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

  int _targetBpm = 80;

  List<HeartLog> get logs => _logs;
  int get targetBpm => _targetBpm;

  // Fungsi untuk menambah log baru ke dalam list state
  void addLog(HeartLog newLog) {
    _logs.insert(0, newLog);
    // Memberi tahu widget yang mendengarkan bahwa terdapat perubahan data
    notifyListeners();
  }

  // Fungsi untuk memperbarui target BPM harian
  void updateTargetBpm(int newTarget) {
    _targetBpm = newTarget;
    // Memberi tahu widget agar melakukan rebuild UI
    notifyListeners();
  }
}
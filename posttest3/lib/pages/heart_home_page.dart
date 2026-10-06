import 'package:flutter/material.dart';
import '../models/heart_log.dart';
import '../widgets/heart_rate_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/history_log_item.dart';
import 'heart_history_page.dart';

class HeartHomePage extends StatefulWidget {
  final List<HeartLog> logs;
  final int targetBpm;
  final Function(HeartLog) onAddLog;
  final Function(int) onUpdateTargetBpm;

  const HeartHomePage({
    super.key,
    required this.logs,
    required this.targetBpm,
    required this.onAddLog,
    required this.onUpdateTargetBpm,
  });

  @override
  State<HeartHomePage> createState() => _HeartHomePageState();
}

class _HeartHomePageState extends State<HeartHomePage> {
  int _selectedIndex = 0;
// kata kunci pencarian
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // memfilter daftar riwayat log berdasarkan input
    final visibleLogs = widget.logs.where((log) {
      final query = searchQuery.toLowerCase();
      return log.category.toLowerCase().contains(query) ||
          log.status.toLowerCase().contains(query) ||
          log.bpm.toString().contains(query);
    }).toList();

  // struktur layar utama
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      
      // safearea
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Joko!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Vital Heart Monitor',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.red.shade700,
                        size: 28,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.trim();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari riwayat (misal: Normal, Olahraga, 78)...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // card Pengukuran BPM
                HeartRateCard(
                  onSaveMeasurement: (int newBpm, String status) {
                    final newLog = HeartLog(
                      id: DateTime.now().toString(),
                      bpm: newBpm,
                      status: status,
                      category: 'Pemeriksaan Mandiri',
                      time: 'Baru Saja',
                    );
                    widget.onAddLog(newLog);
                  },
                ),

                const SizedBox(height: 24),

                const Text(
                  'Ringkasan Harian',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        title: 'Target BPM Harian',
                        value: '${widget.targetBpm} BPM',
                        icon: Icons.speed_rounded,
                        iconColor: Colors.orange.shade600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryCard(
                        title: 'Total Log',
                        value: '${widget.logs.length} Catatan',
                        icon: Icons.monitor_heart_rounded,
                        iconColor: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Riwayat Terakhir',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeartHistoryPage(
                              logs: widget.logs,
                              targetBpm: widget.targetBpm,
                              onUpdateTargetBpm: widget.onUpdateTargetBpm,
                            ),
                          ),
                        );
                      },
                      child: const Text('Lihat Semua'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (visibleLogs.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Tidak ada riwayat ditemukan.',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                  )
                else
                  ...visibleLogs.map((log) => HistoryLogItem(log: log)),
              ],
            ),
          ),
        ),
      ),

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HeartHistoryPage(
                  logs: widget.logs,
                  targetBpm: widget.targetBpm,
                  onUpdateTargetBpm: widget.onUpdateTargetBpm,
                ),
              ),
            );
          }
        },
        selectedItemColor: Colors.red.shade600,
        unselectedItemColor: Colors.grey.shade400,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
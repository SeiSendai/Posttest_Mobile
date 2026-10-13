import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heart_provider.dart';
import '../models/heart_log.dart';
import '../widgets/heart_rate_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/history_log_item.dart';
import 'heart_history_page.dart';

// StatefulWidget untuk halaman utama
class HeartHomePage extends StatefulWidget {
  const HeartHomePage({super.key});

  @override
  State<HeartHomePage> createState() => _HeartHomePageState();
}

class _HeartHomePageState extends State<HeartHomePage> {
  int _selectedIndex = 0;
  String searchQuery = ''; // State lokal untuk pencarian

  @override
  Widget build(BuildContext context) {
    return Consumer<HeartProvider>(
      builder: (context, heartProvider, child) {
        // Memfilter daftar log secara dinamis berdasarkan input pencarian
        final visibleLogs = heartProvider.logs.where((log) {
          final query = searchQuery.toLowerCase();
          return log.category.toLowerCase().contains(query) ||
              log.status.toLowerCase().contains(query) ||
              log.bpm.toString().contains(query);
        }).toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          searchQuery = value.trim(); // Memperbarui state pencarian lokal
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari riwayat (misal: Normal, Olahraga)...',
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

                    HeartRateCard(
                      onSaveMeasurement: (int newBpm, String status) {
                        final newLog = HeartLog(
                          id: DateTime.now().toString(),
                          bpm: newBpm,
                          status: status,
                          category: 'Pemeriksaan Mandiri',
                          time: 'Baru Saja',
                        );
                        context.read<HeartProvider>().addLog(newLog);
                      },
                    ),

                    const SizedBox(height: 24),

                    // Ringkasan Harian
                    const Text(
                      'Ringkasan Harian',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Row & Expanded untuk ringkasan
                    Row(
                      children: [
                        Expanded(
                          child: SummaryCard(
                            title: 'Target BPM Harian',
                            value: '${heartProvider.targetBpm} BPM',
                            icon: Icons.speed_rounded,
                            iconColor: Colors.orange.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SummaryCard(
                            title: 'Total Log',
                            value: '${heartProvider.logs.length} Catatan',
                            icon: Icons.monitor_heart_rounded,
                            iconColor: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Riwayat Terakhir & Tombol Navigasi
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
                                builder: (context) => const HeartHistoryPage(),
                              ),
                            );
                          },
                          child: const Text('Lihat Semua'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Menampilkan log riwayat
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

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              if (index == 1) {
                // Navigator.push saat tab Statistik/Riwayat ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HeartHistoryPage(),
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
      },
    );
  }
}
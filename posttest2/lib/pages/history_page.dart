import 'package:flutter/material.dart';
import '../widgets/history_log_item.dart';
import '../widgets/bottom_sticky_bar.dart';

// Halaman Detail Riwayat (Modul 3)
class HeartHistoryPage extends StatelessWidget {
  const HeartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      
      body: SafeArea(
        //Menumpuk konten halaman scroll dan bottom bar melayang
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Bar dengan Tombol Kembali
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //Kembali ke Halaman Utama
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Detail Riwayat Vital',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Banner Grafik
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          // Menampilkan gambar dari folder assets
                          child: Image.asset(
                            'assets/heart_graph.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.show_chart_rounded,
                                  size: 80,
                                  color: Colors.red.shade300,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Positioned: Menaruh label di pojok bawah gambar
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Grafik Tren BPM 7 Hari',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Catatan Log Terakhir',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Memanggil Widget Item Log Terpisah
                  const HistoryLogItem(
                    title: '78 BPM (Normal)',
                    subtitle: '29 Sep 2026 • 08:30 WITA',
                    category: 'Istirahat',
                    icon: Icons.favorite,
                    iconColor: Colors.red,
                  ),

                  const HistoryLogItem(
                    title: '115 BPM (Tinggi)',
                    subtitle: '28 Sep 2026 • 17:15 WITA',
                    category: 'Olahraga',
                    icon: Icons.directions_run,
                    iconColor: Colors.green,
                  ),
                ],
              ),
            ),

            // Bottom Sticky Bar
            const BottomStickyBar(),
          ],
        ),
      ),
    );
  }
}
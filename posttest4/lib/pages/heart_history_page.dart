import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heart_provider.dart';
import '../widgets/history_log_item.dart';
import '../widgets/target_bpm_input.dart';
import '../widgets/bottom_sticky_bar.dart';

class HeartHistoryPage extends StatelessWidget {
  const HeartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeartProvider>(
      builder: (context, heartProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          
          // SafeArea untuk area aman layar
          body: SafeArea(
            // Menumpuk konten halaman dan sticky bottom bar
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
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

                      TargetBpmInput(
                        targetBpm: heartProvider.targetBpm,
                        onTargetChanged: (newTarget) {
                          heartProvider.updateTargetBpm(newTarget);
                        },
                      ),

                      const SizedBox(height: 20),

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

                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black,
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
                        'Catatan Log Terlengkap',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Menampilkan seluruh log dari provider
                      ...heartProvider.logs.map((log) => HistoryLogItem(log: log)),
                    ],
                  ),
                ),

                const BottomStickyBar(),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/heart_rate_card.dart';
import '../widgets/summary_card.dart';
import 'history_page.dart';

class HeartHomePage extends StatefulWidget {
  const HeartHomePage({super.key});

  @override
  State<HeartHomePage> createState() => _HeartHomePageState();
}

class _HeartHomePageState extends State<HeartHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                    // Container profil pengguna
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

                // Bar Pencarian
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari riwayat atau artikel kesehatan...',
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

                // Card Utama Deteksi Jantung
                const HeartRateCard(),

                const SizedBox(height: 24),

                // Ringkasan Status Kesehatan
                const Text(
                  'Ringkasan Harian',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Row & Expanded untuk 2 kartu ringkasan
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        title: 'Status Jantung',
                        value: 'Normal',
                        icon: Icons.speed_rounded,
                        iconColor: Colors.orange.shade600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryCard(
                        title: 'Kadar Oksigen',
                        value: '98 %',
                        icon: Icons.water_drop_rounded,
                        iconColor: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Card Tombol Navigasi ke Halaman Detail
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HeartHistoryPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.history_rounded, color: Colors.red.shade600, size: 28),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Lihat Analisis Riwayat',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Text(
                                  'Buka grafik & catatan log lengkap',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
                      ],
                    ),
                  ),
                ),
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
            // Navigator.push saat tab Riwayat ditekan
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
  }
}
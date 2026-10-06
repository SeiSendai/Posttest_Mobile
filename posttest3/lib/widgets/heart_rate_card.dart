import 'dart:math';
import 'package:flutter/material.dart';

class HeartRateCard extends StatefulWidget {
  final Function(int bpm, String status) onSaveMeasurement;

  const HeartRateCard({
    super.key,
    required this.onSaveMeasurement,
  });

  @override
  State<HeartRateCard> createState() => _HeartRateCardState();
}

class _HeartRateCardState extends State<HeartRateCard> {
  // state angka BPM dan status
  int currentBpm = 78;
  String currentStatus = 'Normal';
  bool isMeasuring = false;

  // simulasikan proses pengukuran detak jantung
  void _startMeasurement() async {
    // mengubah state indikator
    setState(() {
      isMeasuring = true;
    });

    // simulasi delay proses sensor selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    // menghasilkan angka acak 
    final randomBpm = 65 + Random().nextInt(56);
    final status = randomBpm > 100 ? 'Tinggi' : 'Normal';

    setState(() {
      currentBpm = randomBpm;
      currentStatus = status;
      isMeasuring = false;
    });

    widget.onSaveMeasurement(currentBpm, currentStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.red.shade600,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.red.shade200,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Pemeriksaan Vital',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Menampilkan animasi loading
              if (isMeasuring)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator(color: Colors.white),
                )
              else ...[
                Text(
                  '$currentBpm',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'BPM ($currentStatus)',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: isMeasuring ? null : _startMeasurement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red.shade600,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isMeasuring ? Icons.hourglass_top : Icons.play_arrow_rounded,
                      color: Colors.red.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isMeasuring ? 'Mengukur...' : 'Ukur Detak Jantung',
                      style: TextStyle(
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Badge LIVE
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'LIVE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
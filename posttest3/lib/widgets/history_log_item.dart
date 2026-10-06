import 'package:flutter/material.dart';
import '../models/heart_log.dart';

class HistoryLogItem extends StatelessWidget {
  final HeartLog log;

  const HistoryLogItem({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final bool isHigh = log.bpm > 100;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          Icon(
            isHigh ? Icons.directions_run : Icons.favorite,
            color: isHigh ? Colors.green.shade500 : Colors.red.shade500,
            size: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${log.bpm} BPM (${log.status})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  log.time,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            log.category,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
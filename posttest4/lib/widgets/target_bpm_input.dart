import 'package:flutter/material.dart';

// Widget Stateful untuk input target BPM menggunakan lifecycle initState & didUpdateWidget
class TargetBpmInput extends StatefulWidget {
  final int targetBpm;
  final Function(int) onTargetChanged;

  const TargetBpmInput({
    super.key,
    required this.targetBpm,
    required this.onTargetChanged,
  });

  @override
  State<TargetBpmInput> createState() => _TargetBpmInputState();
}

class _TargetBpmInputState extends State<TargetBpmInput> {
  late TextEditingController targetController;

  // Inisialisasi controller dengan nilai awal
  @override
  void initState() {
    super.initState();
    targetController = TextEditingController(text: '${widget.targetBpm}');
  }

  // Menyelaraskan teks input jika data widget luar diperbarui
  @override
  void didUpdateWidget(covariant TargetBpmInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetBpm != widget.targetBpm &&
        targetController.text != '${widget.targetBpm}') {
      targetController.text = '${widget.targetBpm}';
    }
  }

  @override
  void dispose() {
    targetController.dispose();
    super.dispose();
  }

  void _updateTarget(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 40) return;
    widget.onTargetChanged(parsed.clamp(40, 180));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Atur Target BPM',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'Batas aman detak harian',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            width: 80,
            child: TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: _updateTarget,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
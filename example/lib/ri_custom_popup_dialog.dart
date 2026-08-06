import 'dart:async';
import 'package:flutter/material.dart';

class RiCustomPopupDialog extends StatefulWidget {
  final String unitId;
  const RiCustomPopupDialog({super.key, required this.unitId});

  @override
  State<RiCustomPopupDialog> createState() => _RiCustomPopupDialogState();
}

class _RiCustomPopupDialogState extends State<RiCustomPopupDialog> {
  int _countdown = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() { _countdown--; });
      if (_countdown <= 0) {
        _timer?.cancel();
        if (mounted) Navigator.of(context).pop(true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 헤더
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFE65100),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "광고 시청 후 보상 받기!",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBF360C),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          // 본문
          Container(
            width: double.infinity,
            color: const Color(0xFFFFF8E1),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: const Column(
              children: [
                Text(
                  "광고를 시청하고\n보상을 받으세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF4E342E), fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 20),
                Divider(color: Color(0xFFFFCC80)),
                SizedBox(height: 16),
                Text(
                  "상대를 파산시켰어요!",
                  style: TextStyle(color: Color(0xFFE64A19), fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          // 잠시 후 광고 버튼
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: const Color(0xFFFF8F00),
            child: const Text(
              "잠시 후 광고가 시작됩니다",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          // 카운트다운 배너
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD600),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.play_arrow, color: Colors.black87, size: 22),
                    SizedBox(width: 4),
                    Text("광고보고 보상 받기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                  ],
                ),
                const SizedBox(height: 2),
                Text("$_countdown초 후 자동 재생", style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

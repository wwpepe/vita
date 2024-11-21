import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'package:test111/api/user_data.dart';


class HeartRateScreen extends StatefulWidget {
  @override
  _HeartRateScreenState createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  final UserData _userData = UserData();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 심박수 데이터를 주기적으로 업데이트
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _userData.generateHeartRate(); // 데이터 생성
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: const Color(0xFFFFF6F6), // 연한 핑크색 배경
          child: SizedBox(
            width: 250,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 아이콘과 제목
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      const SizedBox(width: 8),
                      const Text(
                        "Heart Rate",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 그래프
                  Expanded(
                    child: CustomPaint(
                      painter: HeartRateGraphPainter(_userData.getHeartRates()),
                      child: Container(),
                    ),
                  ),
                  // 심박수 표시
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${_userData.getHeartRates().last} Bpm",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeartRateGraphPainter extends CustomPainter {
  final List<int> heartRates;

  HeartRateGraphPainter(this.heartRates);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;
    final centerY = size.height / 2;
    final double barSpacing = size.width / 20; // 데이터사이 간격.
    for (int i = 0; i < heartRates.length; i++) {
      final x = i * barSpacing;
      final barHeight = (heartRates[i] - 50) / 70 * size.height / 2; // Normalize to fit the graph
      canvas.drawLine(
        Offset(x, centerY- barHeight),
        Offset(x, centerY+ barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
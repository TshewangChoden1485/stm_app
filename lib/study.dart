import 'package:flutter/material.dart';
import 'dart:async';
import 'data.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  int _minutes = 25;
  int _seconds = 0;
  bool _isRunning = false;
  bool _isBreak = false;
  Timer? _timer;

  int get _remainingSeconds => _minutes * 60 + _seconds;
  int get _sessionSeconds => _isBreak ? 10 * 60 : 25 * 60;
  double get _progress => _remainingSeconds / _sessionSeconds;
  String get _sessionLabel => _isBreak ? 'Break' : 'Study';

  void _startTimer() {
    if (_timer != null) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else if (_minutes > 0) {
          _minutes--;
          _seconds = 59;
        } else {
          _timer?.cancel();
          _timer = null;
          _isRunning = false;
          if (_isBreak) {
            _minutes = 25;
            _seconds = 0;
            _isBreak = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Break over! Back to study.')),
            );
          } else {
            _minutes = 10;
            _seconds = 0;
            _isBreak = true;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Focus session complete! Take a break.')),
            );
          }
        }
        if (!_isBreak && _isRunning) {
          totalStudySeconds++;
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _minutes = 25;
      _seconds = 0;
      _isRunning = false;
      _isBreak = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double circleSize = screenWidth * 0.95;
    if (circleSize > screenHeight * 0.62) circleSize = screenHeight * 0.62;
    double strokeWidth = circleSize * 0.045;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Study With Me'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        top: circleSize * 0.045,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white24,
                                blurRadius: 6,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: circleSize * 0.9,
                        height: circleSize * 0.9,
                        child: CircularProgressIndicator(
                          value: _progress,
                          strokeWidth: strokeWidth,
                          backgroundColor: Colors.white12,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _sessionLabel,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _isBreak ? 'Break' : 'Focus',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDE90FE),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pauseTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A8AFF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Pause',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF444444),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'End',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoChip(
                  'Break time',
                  '25 mins',
                  onTap: () {
                    setState(() {
                      _isBreak = true;
                      _minutes = 25;
                      _seconds = 0;
                    });
                    _startTimer();
                  },
                ),
                _infoChip(
                  'Break time ',
                  '10 mins',
                  onTap: () {
                    setState(() {
                      _isBreak = true;
                      _minutes = 10;
                      _seconds = 0;
                    });
                    _startTimer();
                  },
                ),
                _infoChip(
                  'Study Hour',
                  '${(totalStudySeconds / 3600).toStringAsFixed(1)}h',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Total study time: ${(totalStudySeconds / 3600).toStringAsFixed(1)} hours'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String label, String value, {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

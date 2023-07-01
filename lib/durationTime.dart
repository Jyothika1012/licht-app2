import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DurationTime extends StatefulWidget {
  const DurationTime({super.key});

  @override
  State<DurationTime> createState() => _DurationTimeState();
}

class _DurationTimeState extends State<DurationTime> {
  static const countdownDuration = Duration(minutes: 10);
  Duration duration = Duration();
  Timer? timer;
  bool isCountdown = true;
  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: const Text(
          "Duration Time",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(child: buildTime()),
    );
  }

  Widget buildTime() {
    String twodigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twodigits(duration.inMinutes.remainder(60));
    final seconds = twodigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildtimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(width: 8),
        buildtimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildtimeCard({required String time, required String header}) => Text(
        time,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 72,
        ),
      );
}

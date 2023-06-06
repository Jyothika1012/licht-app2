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
  Timer? timer;
  Duration duration = Duration();
  bool isCountdown = true;

  @override
  void initState() {
    super.initState();

    startTime();
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

  void startTime() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTime(),
            const SizedBox(height: 80),
            buildButtons(),
          ],
        ),
      ),
    );

    Widget buildTime() {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimeCard(time: hours, header: 'HOURS'),
          const SizedBox(width: 8),
          buildTimeCard(time: minutes, header: 'MINUTES'),
          const SizedBox(width: 8),
          buildTimeCard(time: seconds, header: 'SECONDS'),
        ],
      );
    }

    Widget buildTimeCard({required String time, required String header}) =>
        Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 72,
          ),
        );

    Widget buildButtons() {
      final isRunning = false;

      return isRunning
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: 'STOP',
                  onclicked: () {},
                ),
                const SizedBox(width: 12),
                ButtonWidget(
                  text: 'CANCEL',
                  onclicked: () {},
                ),
              ],
            )
          : ButtonWidget(
              text: 'Start Timer!',
              Color: Colors.black,
              backgroundcolor: Colors.white,
              onclicked: () {},
            );
    }
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) => Text(
        time,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 72,
        ),
      );
}

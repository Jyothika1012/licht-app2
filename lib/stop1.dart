import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  String hoursString = "00", minuteString = "00", secondString = "00";
  int hours = 0, minutes = 0, seconds = 0;
  bool isTimerRunning = false, isResetButtonVisible = false;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _startSecond();
    });
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      isTimerRunning = false;
    });
    isResetButtonVisible = checkValues();
  }

  void _startSecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          secondString = "0" + secondString;
        }
      } else {
        _startMinutes();
      }
    });
  }

  void _startMinutes() {
    setState(() {
      if (minutes < 59) {
        seconds = 0;
        secondString = "00";
        minutes++;
        minuteString = minutes.toString();
        if (minuteString.length == 1) {
          minuteString = "0" + minuteString;
        } else {
          _starthours();
        }
      }
    });
  }

  void _starthours() {
    setState(() {
      seconds = 0;
      minutes = 0;
      secondString = "00";
      minuteString = "00";
      hours++;
      hoursString = hours.toString();
      if (hoursString.length == 1) {
        hoursString = "0" + hoursString;
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      secondString = "00";
      minuteString = "00";
      hoursString = "00";
      isResetButtonVisible = false;
    });
  }

  bool checkValues() {
    if (seconds != 0 || minutes != 0 || hours != 0) {
      return true;
    } else {
      return false;
    }
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
          "StopWatch",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$hoursString:$minuteString:$secondString",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (isTimerRunning = true) {
                      pauseTimer();
                    } else {
                      startTimer();
                    }
                  },
                  child: Text(isTimerRunning ? "pause" : "play")),
              isResetButtonVisible
                  ? ElevatedButton(
                      onPressed: () {
                        resetTimer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text("Reset"),
                      ),
                    )
                  : SizedBox(),
            ]),
      ),
    );
  }
}

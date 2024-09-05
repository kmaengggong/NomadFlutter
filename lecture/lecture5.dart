// main.dart
import 'package:flutter/material.dart';
// home_screen.dart
import 'dart:async';


// main.dart
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE7626C),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}


// home_screen.dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const TWENTY_FIVE_MINS = 1500;
  int totalSeconds = TWENTY_FIVE_MINS;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;
  
  void onTick(Timer timer) {
    if(totalSeconds == 0){
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        totalSeconds = TWENTY_FIVE_MINS;
      });
      timer.cancel();
    }
    setState(() => totalSeconds -= 1);
  }
  
  void onStartPressed() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      onTick,
    );
    setState(() => isRunning = true);
  }
  
  void onPuasePressed() {
    timer.cancel();
    setState(() => isRunning = false);
  }
  
  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = TWENTY_FIVE_MINS;
    });
  }
  
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration
      .toString()
      .split(".")
      .first
      .substring(2, 7);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    color: Theme.of(context).cardColor,
                    icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline
                    ),
                    iconSize: 120,
                    onPressed: isRunning
                      ? onPuasePressed
                      : onStartPressed
                  ),
                  IconButton(
                    color: Theme.of(context).cardColor,
                    icon: Icon(Icons.replay_outlined),
                    iconSize: 120,
                    onPressed: onResetPressed,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headlineLarge!.color,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "$totalPomodoros",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headlineLarge!.color,
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

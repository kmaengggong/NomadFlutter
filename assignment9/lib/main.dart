import 'package:flutter/material.dart';
import 'dart:async';
// import 'dart:io';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorLight: const Color(0xFFE64D3D),
        primaryColorDark: const Color(0xFF3EE68E),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // constants
  static const FIFTEEN_MINS = 15; //900;
  static const TWENTY_MINS = 20; //1200;
  static const TWENTY_FIVE_MINS = 25; //1500;
  static const THIRTY_MINS = 30; //1800;
  static const THIRTY_FIVE_MINS = 35; //2100;
  static const REST_TIME = 5; //300;

  // variables
  int selectedSeconds = TWENTY_FIVE_MINS;
  int totalSeconds = TWENTY_FIVE_MINS;
  int totalRounds = 0;
  int totalGoals = 0;
  int selectedIndex = 3;

  bool isRunning = true;
  bool isResting = false;
  bool isPause = true;
  bool isStarted = false;

  late Timer timer;
  final ScrollController _scrollController = ScrollController();

  // styles
  ButtonStyle outlinedButtonstyle(bool isSelected) => OutlinedButton.styleFrom(
      foregroundColor: !isSelected
          ? Colors.white.withOpacity(0.9)
          : isResting
              ? const Color(0xFF3EE68E)
              : const Color(0xFFE64D3D),
      backgroundColor: isSelected
          ? Colors.white.withOpacity(0.9)
          : isResting
              ? const Color(0xFF3EE68E)
              : const Color(0xFFE64D3D),
      side: BorderSide(
        width: 3,
        color: Colors.white.withOpacity(0.9),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))));

  // functions
  void onTick(Timer timer) {
    setState(() => totalSeconds -= 1);
    if (totalSeconds == 0) {
//       sleep(const Duration(seconds:1));
      setState(() {
        if (isRunning) {
          isRunning = false;
          isResting = true;
          totalRounds += 1;
          if (totalRounds > 3) {
            totalRounds = 0;
            totalGoals += 1;
          }
          totalSeconds = REST_TIME;
        } else if (isResting) {
          isResting = false;
          isRunning = true;
          totalSeconds = selectedSeconds;
        }
      });
    }
  }

  void onStartPressed() {
    if (!isStarted) isStarted = true;
    if (totalGoals > 11) return;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() => isPause = false);
  }

  void onPausePressed() {
    timer.cancel();
    setState(() => isPause = true);
  }

  void onResetPressed() {
    if (isStarted) timer.cancel();
    setState(() {
      isRunning = true;
      isResting = false;
      isPause = true;
      totalSeconds = selectedSeconds;
    });
  }

  void onSelectPressed(int order) {
    if (isStarted) timer.cancel();
    setState(() {
      isRunning = true;
      isResting = false;
      isPause = true;
      selectedIndex = order;

      if (order == 1)
        selectedSeconds = FIFTEEN_MINS;
      else if (order == 2)
        selectedSeconds = TWENTY_MINS;
      else if (order == 3)
        selectedSeconds = TWENTY_FIVE_MINS;
      else if (order == 4)
        selectedSeconds = THIRTY_MINS;
      else if (order == 5) selectedSeconds = THIRTY_FIVE_MINS;
      totalSeconds = selectedSeconds;
    });
  }

  List<String> formatTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    String miniutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return [miniutesStr, secondsStr];
  }

  // override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent / 2);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isResting
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColorLight,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "POMOTIMER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 130),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimeCard(formatTime(totalSeconds)[0], isResting),
                const SizedBox(width: 10),
                Text(
                  ":",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 64,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                TimeCard(formatTime(totalSeconds)[1], isResting),
              ],
            ),
            const SizedBox(height: 60),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => onSelectPressed(1),
                    style: outlinedButtonstyle(selectedIndex == 1),
                    child: const SelectText(15),
                  ),
                  const SizedBox(width: 15),
                  TextButton(
                    onPressed: () => onSelectPressed(2),
                    style: outlinedButtonstyle(selectedIndex == 2),
                    child: const SelectText(20),
                  ),
                  const SizedBox(width: 15),
                  TextButton(
                    onPressed: () => onSelectPressed(3),
                    style: outlinedButtonstyle(selectedIndex == 3),
                    child: const SelectText(25),
                  ),
                  const SizedBox(width: 15),
                  TextButton(
                    onPressed: () => onSelectPressed(4),
                    style: outlinedButtonstyle(selectedIndex == 4),
                    child: const SelectText(30),
                  ),
                  const SizedBox(width: 15),
                  TextButton(
                    onPressed: () => onSelectPressed(5),
                    style: outlinedButtonstyle(selectedIndex == 5),
                    child: const SelectText(35),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    color: Colors.white,
                    icon: Icon(isPause
                        ? Icons.play_circle_outline
                        : Icons.pause_circle_outline),
                    iconSize: 120,
                    onPressed: isPause ? onStartPressed : onPausePressed),
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.replay_outlined),
                  iconSize: 120,
                  onPressed: onResetPressed,
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "$totalRounds/4",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "ROUND",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 150),
                Column(
                  children: [
                    Text(
                      "$totalGoals/12",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "GOAL",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  final String text;
  final bool isResting;

  const TimeCard(this.text, this.isResting, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 46,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isResting
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColorLight,
            fontSize: 76,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class SelectText extends StatelessWidget {
  final int minutes;

  const SelectText(this.minutes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Text(
        "$minutes",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

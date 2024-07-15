import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

import 'package:slash/upgrades.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int counter = 5000;
  int maxTapCount = 100;
  Timer? _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _loadMaxTapCount();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    if (maxTapCount < 100) {
      _startAutoIncrement();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    if (maxTapCount > 0) {
      setState(() {
        counter++;
        maxTapCount--;
      });
      _saveCounter();
      _saveMaxTapCount();
      _animationController.forward(from: 0);
      if (maxTapCount == 0) {
        _startAutoIncrement();
      }
    }
  }

  void _startAutoIncrement() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        maxTapCount++;
      });
      _saveMaxTapCount();
      if (maxTapCount >= 100) {
        _timer?.cancel();
      }
    });
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 5000;
    });
  }

  Future<void> _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
  }

  Future<void> _loadMaxTapCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      maxTapCount = prefs.getInt('maxTapCount') ?? 100;
    });

    // Load the timestamp of the last save
    int? lastTimestamp = prefs.getInt('lastTimestamp');
    if (lastTimestamp != null) {
      int elapsedSeconds = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(lastTimestamp))
          .inSeconds;
      int incrementAmount = elapsedSeconds;
      setState(() {
        maxTapCount += incrementAmount;
        if (maxTapCount > 100) {
          maxTapCount = 100;
        }
      });
    }
  }

  Future<void> _saveMaxTapCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('maxTapCount', maxTapCount);
    // Save the current timestamp
    prefs.setInt('lastTimestamp', DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = maxTapCount / 100;

    return Scaffold(
      backgroundColor: const Color(0xFFFF8552),
      body: Container(
        padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Upgrades(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xFF85FFC7),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_circle_down,
                              color: Color(0xFF007F76),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Upgrade',
                              style: TextStyle(
                                  color: Color(0xFF007F76), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/coy.png',
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      '$counter',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 34,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'Level 1',
                  style: TextStyle(
                      color: Color(0xFF39393A),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: _incrementCounter,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    child: Image.asset(
                      'lib/images/stap.png',
                      width: 140,
                      height: 140,
                    ),
                    builder: (context, child) {
                      double shake = sin(_animationController.value * 2 * pi) *
                          5; // 5 is the shake intensity
                      return Transform.translate(
                        offset: Offset(shake, 0),
                        child: child,
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'lib/images/coy.png',
                                width: 12,
                                height: 12,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '$maxTapCount / 100',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 60,
                            height: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                backgroundColor: const Color(0xFF93FFF9),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF297373)),
                                value: progressValue,
                                minHeight: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Image.asset(
                            'lib/images/coy.png',
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Boost',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

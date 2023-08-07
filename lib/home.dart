import 'dart:async';
import 'dart:ui';

import 'package:flappy_bird_game/barriers.dart';
import 'package:flappy_bird_game/bird.dart';
import 'package:flappy_bird_game/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barriedXone = 2;
  double barriedXtwo = barriedXone + 1.5;
  late int score = 0;
  late int bestScore = 0;

  void jump() {
    setState(() {
      time = 0;
      score += 1;
      initialHeight = birdYaxis;
    });

    if (score >= bestScore) {
      bestScore = score;
    }
  }

  bool birdIsDead() {
    if (birdYaxis > 1 || birdYaxis < -1) {
      return true;
    }
    return false;
  }

  void startGame() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      gameHasStarted = true;
      score = 0;
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        if (barriedXone < -1.1) {
          barriedXone += 2.2;
        } else {
          barriedXone -= 0.05;
        }

        if (birdIsDead()) {
          timer.cancel();
          _showDialog();
        }
        if (barriedXtwo < -1.1) {
          barriedXtwo += 2.2;
        } else {
          barriedXtwo -= 0.05;
        }
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Image.asset(AssetsConstants.gameover),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const Text(
                    'Start Again',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(children: [
                AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  duration: const Duration(milliseconds: 0),
                  color: Colors.lightBlueAccent,
                  child: const Bird(),
                ),
                Container(
                  alignment: const Alignment(0, -0.65),
                  child: gameHasStarted
                      ? const Text('')
                      : Image.asset(AssetsConstants.play),
                ),
                AnimatedContainer(
                  alignment: Alignment(barriedXone, 1.1),
                  duration: const Duration(milliseconds: 0),
                  child: const Barriers(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barriedXone, -1.3),
                  duration: const Duration(milliseconds: 0),
                  child: const Barriers(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barriedXtwo, 1.2),
                  duration: const Duration(milliseconds: 0),
                  child: const Barriers(
                    size: 250.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barriedXtwo, -1.2),
                  duration: const Duration(milliseconds: 0),
                  child: const Barriers(
                    size: 250.0,
                  ),
                ),
              ]),
            ),
            Container(
              height: 10,
              color: Colors.amberAccent,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsConstants.score,
                          height: 50,
                        ),
                        const Text(
                          'SCORE',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsConstants.top,
                          height: 50,
                        ),
                        const Text(
                          'BEST',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bestScore.toString(),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

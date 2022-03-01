import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'Barriers.dart';
import 'package:flutter/material.dart';
import 'MyBird.dart';

void main() {
  runApp(Page());
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homePage();
  }
}

class _homePage extends State<homePage> {
  static double BirdYaxis = -0.4;
  bool v = true;
  double height = 0;
  double iH = BirdYaxis;
  double time = 0;
  double BarrierXaxis1 = 1.3;
  double BarrierXaxis2 = 1;
  int score = 0;
  bool g = true;
  static var rng = new Random();
  double x = rng.nextDouble() + 1;

  void startgame() {
    v = false;
    Timer.periodic(Duration(milliseconds: 90), (timer) {
      time += 0.03;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        BirdYaxis = iH - height;
        BarrierXaxis1 -= 0.1;
      });
      if (BirdYaxis > 1) {
        BirdYaxis = 1;
      }
      if (BarrierXaxis1 <= 0.35 && BarrierXaxis1 >= -0.3) {
        if (BirdYaxis >= x - 0.7) {
          timer.cancel();
          v = true;
          g = false;
        }
      }
    }
    );
  }

  Widget setNewBarrier(double f) {
    if (BarrierXaxis1 < -1.3) {
      BarrierXaxis1 = 1.3;
      x = rng.nextDouble() + 1;
      score++;
      return _Bariers(BarrierXaxis1, f);
    } else {
      return _Bariers(BarrierXaxis1, f);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (v == false) {
                        if(g==true) {
                          jump();
                        }
                        else{
                          BarrierXaxis1 = -0.3;
                        }
                      } else {
                        startgame();
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment(0, BirdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.lightBlue,
                      child: Bird(),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, -0.9),
                    child: Text(x.toString()),                  ),

                  Container(
                    alignment: Alignment(0, -0.6),
                    child: Text(BirdYaxis.toString()),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: v == false
                        ? null
                        : Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                  setNewBarrier(x)
                ],
              )),
          Expanded(
              child: Stack(children: [
            Container(
              color: Colors.green,
            ),
            Padding(
                padding: EdgeInsets.only(top: 25),
                child: Container(
                  alignment: Alignment(0,-0.5),
                  color: Colors.brown,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Text(
                    "Score\n\t\t\t\t$score",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                )),
          ])),
        ],
      ),
    );
  }

  void jump() {
    setState(() {
      time = 0;
      iH = BirdYaxis;
    });
  }

  Widget _Bariers(double z, double c) {
    return AnimatedContainer(
      alignment: Alignment(z, c),
      duration: Duration(milliseconds: 0),
      child: Barriers(
        size: 200,
      ),
    );
  }
}

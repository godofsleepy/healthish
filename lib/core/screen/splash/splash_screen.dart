import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthish/core/common/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController imageAnimationController;
  late AnimationController textAnimationController;
  late Animation<double> imageAnimation;
  late Animation<double> textAnimation;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    setUpAnimation();
    movingToNextScreen();
    // var snapshot = FirebaseFirestore.instance
    //     .collection('app-config')
    //     .doc("dev")
    //     .get()
    //     .then((value) {
    //   Map<String, dynamic> data = value.data() as Map<String, dynamic>;
    //   print(json.encode(data));
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Constants.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/ambulance.gif"),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: imageAnimation,
                  child: Image.asset("assets/medical_icon.png"),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  width: 10,
                ),
                SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: textAnimation,
                  axis: Axis.horizontal,
                  child: Text(
                    "Healthish",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setUpAnimation() {
    imageAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
      value: 0.1,
    );
    textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3,
      ),
    );
    imageAnimation = CurvedAnimation(
      curve: Curves.easeInCirc,
      parent: imageAnimationController,
    );
    textAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: textAnimationController,
    );
    imageAnimationController.forward();
    textAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    textAnimationController.dispose();
    imageAnimationController.dispose();
  }

  movingToNextScreen() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var isGuided = sharedPreferences.getBool(Constants.KEY_GUIDE);
    // if (isGuided == null) {
    Timer(
        Duration(
          seconds: 5,
        ), () {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Guide(),
      //     ));
    });
    // } else {
    //   Timer(
    //       Duration(
    //         seconds: 5,
    //       ), () {
    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => MainNavigation(),
    //         ));
    //   });
    // }
  }
}

import 'package:background_animation/components/wheel.dart';
import 'package:background_animation/pages/background_animation_v2.dart';
import 'package:background_animation/pages/spinwheel_animation.dart';
import 'package:background_animation/pages/spinwheel_animation_v2.dart';
import 'package:background_animation/pages/winner_animation.dart';
import 'package:background_animation/widget/spinwheel.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GoogleFonts.config.allowRuntimeFetching = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade300),
        useMaterial3: true,
      ),
      // home: MyBackGround(),
      home: MyBackGroundV2(), //DEFINITIVO => principal
      // home: MyFortuneWheel(),
      // home: MyFortuneWheel2(),
      // home: MySpinWheel(), //definitivo
      // home: MyWinnerCard(),
      // home: MyEnviroment(),
      // home: MyHomeScreen()
    );
  }
}

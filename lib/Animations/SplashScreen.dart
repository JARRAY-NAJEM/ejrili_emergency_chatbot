import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ejrili_yammi/Screen/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 500,
        backgroundColor: const Color(0xFFeff2f9),
        // splashTransition: SplashTransition.slideTransition,

        splash: Center(
          child: Lottie.asset('animations/splashRed.json'),
          //https://assets6.lottiefiles.com/packages/lf20_xaGveK.json
          //https://assets5.lottiefiles.com/temp/lf20_BjrC73.json
        ),
        nextScreen: WelcomePage(),
        duration: 2000,
        animationDuration: const Duration(milliseconds: 2200));
  }
}

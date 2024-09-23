import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class OnboardingPage extends StatelessWidget {
  final String animation;
  final String title;
  final String subtitle;

  const OnboardingPage({super.key, 
    required this.animation,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child:  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Lottie.asset(animation),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Vx.gray900),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Vx.gray700),
          ),
        ],
      ),
    ));
  }
}

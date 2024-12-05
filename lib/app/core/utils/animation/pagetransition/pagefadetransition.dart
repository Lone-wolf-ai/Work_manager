import 'package:flutter/material.dart';

class PageFadeTransition extends PageRouteBuilder {
  final Widget page;

  PageFadeTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return Align(
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}


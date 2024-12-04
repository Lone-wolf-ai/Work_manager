import 'package:flutter/material.dart';

class PageScaleTransitionDouble extends PageRouteBuilder {
  final Widget page;

  PageScaleTransitionDouble(this.page)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            var _animation = Tween<double>(begin: 0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
            );
            var _animation2 = Tween<double>(begin: 0, end: 2.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn),
            );
            return ScaleTransition(
              scale: _animation,
              child: RotationTransition(
                turns: _animation2,
                child: child,

              ),
            );
          },
        );
}


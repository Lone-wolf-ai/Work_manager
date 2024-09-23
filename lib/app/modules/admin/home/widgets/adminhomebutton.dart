import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Adminhomebutton extends StatelessWidget {
  const Adminhomebutton({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.title,
    this.showAlert = false,
  });

  final VoidCallback onPressed;
  final IconData iconData;
  final String title;
  final bool showAlert;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Vx.gray800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(80, 70),
              ),
              child: Icon(
                iconData,
                color: Colors.white,
                size: 35,
              ),
            ),
            if (showAlert)
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        2.heightBox,
        title.text.bold.gray800.size(16).make(),
      ],
    );
  }
}

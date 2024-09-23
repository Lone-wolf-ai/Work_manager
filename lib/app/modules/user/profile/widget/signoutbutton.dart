import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class SignoutButton extends StatelessWidget {
  const SignoutButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
           backgroundColor: Colors.red,
           // Text and icon color
          side: const BorderSide(color: Colors.red, width: 1.5), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), 
          ),
          minimumSize: const Size(120, 50), 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Iconsax.logout,
              color: Colors.white,
            ),
            2.widthBox,
            "Sign Out".text.semiBold.size(16).white.make(),
          ],
        ),
      ),
    ).centered();
  }
}

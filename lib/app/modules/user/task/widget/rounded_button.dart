import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.onStart, required this.title});
  final VoidCallback onStart;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onStart,
      style: ElevatedButton.styleFrom(
        backgroundColor: Vx.gray900, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), 
      ),
      child: title.text.white.bold.size(20).make(), 
    );
  }
}

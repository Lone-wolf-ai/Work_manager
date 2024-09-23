import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.action,
    required this.checkin,
    required this.checkout,
  });
  final VoidCallback action;
  final bool checkin;
  final bool checkout;
  @override
  Widget build(BuildContext context) {
    String status='';
    if(checkin ==false && checkout ==false){
         status="Slide to Check In";
    }
    else if(checkin==true&&checkout==false){
      status="Slide to Check Out";
    }
    else{
      status="Checked Out";
    }
    return SlideAction(
      trackHeight: 70,
      thumbWidth: double.infinity,
      trackBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[100],
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1,
              ),
            ],
          ),
        );
      },
      thumbBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
              child: status.text.size(16).bold.white.make()),
        );
      },
      action: action,
    );
  }
}

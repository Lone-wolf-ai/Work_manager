import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controller/controller.dart';

class LongPressFAB extends StatelessWidget {
  const LongPressFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LongPressFABController>(
      init: LongPressFABController(),
      builder: (controller) {
        return GestureDetector(
          onLongPressStart: (details) {
            controller.startTimer();
            controller.isPressed.value = true;
          },
          onLongPressEnd: (details) {
            controller.cancelTimer();
            controller.isPressed.value = false;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color:Vx.white, width: 4.0),
                ),
                child: FloatingActionButton(
                  onPressed: () {
                  },
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.fingerprint,
                    size: 42,
                  ),
                ),
              ),
              Positioned.fill(
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.transparent,
                        width: 6.0,
                      ),
                    ),
                    child: CircularProgressIndicator(
                      value: controller.progressValue.value,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.transparent,
                      strokeWidth: 6.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
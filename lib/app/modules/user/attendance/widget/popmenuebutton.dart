import 'package:velocity_x/velocity_x.dart';

import '../../../../core/utils/constants/string_const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomPoPMenue extends StatelessWidget {
  const CustomPoPMenue({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Vx.white,
      icon: const Icon(
        Icons.calendar_month_outlined,
        color: Vx.black,
        size: 24,
      ),
      onSelected: (String value) {
        // handle the tap event for the selected item here
        if (kDebugMode) {
          print("Selected: $value");
        }
      },
      itemBuilder: (BuildContext context) {
        return StringConst.popmenuestring.map((String month) {
          return PopupMenuItem<String>(
            value: month,
            child: Text(month),
          );
        }).toList();
      },
    );
  }
}

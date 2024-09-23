  import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar taskdetailappbar() {
    return AppBar(
      backgroundColor: Vx.white,
      foregroundColor: Vx.black,
      title: "Task Details".text.size(24).bold.black.make(),
    );
  }
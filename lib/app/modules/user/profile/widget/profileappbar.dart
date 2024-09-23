import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar profileappbar() {
  return AppBar(
    backgroundColor: Vx.white,
    title: "Profile".text.bold.black.size(24).make(),
    actions: [IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit,color: Vx.black,))],
  );
}

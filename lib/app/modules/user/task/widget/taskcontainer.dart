import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TaskContainer extends StatelessWidget {
  final List<String> avatars =
      List.generate(5, (index) => '');

  TaskContainer(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Icon(icon, size: 40, color: Vx.gray700).objectTopLeft(),
        2.heightBox,
        title.text.bold.size(24).make(),
        // 8.heightBox,
        // HStack(
        //   [
        //     ...avatars.take(3).map((url) => CircleAvatar(
        //           radius: 12,
        //           backgroundImage: NetworkImage(url),
        //         )
        //             .box
        //             .roundedFull
        //             .border(width: 1, color: Vx.white)
        //             .make()
        //             .paddingSymmetric(horizontal: 2)),
        //     if (avatars.length > 3)
        //       CircleAvatar(
        //         radius: 12,
        //         backgroundColor: Vx.gray700,
        //         child: "+${avatars.length - 3}".text.size(16).white.make().p(2),
        //       ).paddingSymmetric(horizontal: 4),
        //   ],
        //   alignment: MainAxisAlignment.start,
        // ),
        // 8.heightBox,
        subtitle.text.semiBold.size(22).gray600.make().paddingSymmetric(vertical: 4),
      ],
      crossAlignment: CrossAxisAlignment.start,
    )
        .box
        .width(double.infinity)
        .padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 8))
        .roundedSM
        .white
        .make();
  }
}

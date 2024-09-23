import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../data/models/applicationmodel.dart';
import 'detailpage.dart';

class BoxItemWidget extends StatelessWidget {
  final BoxItem item;

  const BoxItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Vx.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade300, 
          width: 2.0, 
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.title.text.bold.make(),
          8.heightBox,
          'Date: ${item.date.toLocal().toIso8601String().split('T').first}'
              .text
              .gray400
              .make(),
          8.heightBox,
          item.description.text.semiBold.make()
        ],
      ),
    ).onTap(() => Get.to(() => DetailPage(
          title: item.title,
          description: item.description,
        )));
  }
}

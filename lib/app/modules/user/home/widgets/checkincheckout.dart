import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/homecontroller.dart';

class ChekInCheckOut extends StatelessWidget {
  final String? checkin;
  final String? checkout;
  final String? totalHours;

  const ChekInCheckOut({
    super.key,
    this.checkin,
    this.checkout,
    this.totalHours,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(HomeController());
    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Vx.gray300,width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(
        ()=> Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildColumn("Check IN", controller.record.value.checkIn!=null?controller.record.value.checkIn!.time:"__/__"),
            _buildColumn("Check Out", controller.record.value.checkOut!=null?controller.record.value.checkOut!.time:"__/__"),
            _buildColumn("Total Hrs", controller.record.value.totalHours ?? "__/__"),
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: 16);
  }

  Widget _buildColumn(String title, String? value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title.text.gray600.bold.size(18).make(),
        const SizedBox(height: 5),
        (value ?? '__/--').text.gray700.semiBold.size(18).make(),
      ],
    );
  }
}


class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: 16),
    );
  }
}

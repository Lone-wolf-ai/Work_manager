import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        backgroundColor: Vx.white,
        actions: const [],
        title: "Emplyoee".text.bold.gray800.size(24).make(),
      ),
      body: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return 10.heightBox;
        },
        itemBuilder: (BuildContext context, int index) {
          return const EmployeeCard();
        },
      ).paddingOnly(left: 16,right: 16,bottom: 16),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            26.widthBox,
            const CircleAvatar(
              radius: 42,
            ),
            24.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Name: Syed Tanjim Ahmed".text.semiBold.gray800.size(18).make(),
                2.heightBox,
                Container(
                  width: 240,
                  height: 2,
                  color: Vx.gray300,
                ),
                2.heightBox,
                "Title: Nothing".text.semiBold.gray800.size(18).make(),
                Container(
                  width: 240,
                  height: 2,
                  color: Vx.gray300,
                ),
                2.heightBox,
                "Blood Group: A-".text.semiBold.gray800.size(18).make(),
                Container(
                  width: 240,
                  height: 2,
                  color: Vx.gray300,
                ),
                2.heightBox,
                "Phone: +8801745583607".text.semiBold.gray800.size(18).make(),
              ],
            )
          ],
        )
      ],
    ).box.border().roundedLg.p4.white.make();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({
    super.key,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.username,
  });

  final String phoneNumber;
  final String email;
  final String address;
  final String? username;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.grey[600],
            ),
            12.widthBox,
            Row(
              children: [
                "User name: ".text.bold.xl.maxLines(1).ellipsis.gray600.make(),
              if(username!=null) username!.text.capitalize.bold.xl
                    .maxLines(1)
                    .ellipsis
                    .gray600
                    .make(),
              ],
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Icon(
              Iconsax.call,
              color: Colors.grey[600],
            ),
            12.widthBox,
            "Phone: $phoneNumber"
                .text
                .bold
                .xl
                .maxLines(1)
                .ellipsis
                .gray600
                .make(),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Icon(
              Icons.mail_outline,
              color: Colors.grey[600],
            ),
            12.widthBox,
            "Email: $email".text.bold.xl.ellipsis.maxLines(1).gray600.make(),
          ],
        ),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Iconsax.location,
              color: Colors.grey[600],
            ),
            12.widthBox,
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Address: ".text.bold.xl.gray600.ellipsis.maxLines(4).make(),
                  Flexible(
                    child: address.text.bold.xl.gray600.ellipsis
                        .maxLines(4)
                        .make(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    )
        .paddingSymmetric(horizontal: 16, vertical: 16)
        .box
        .border(width: 1)
        .width(double.infinity)
        .rounded
        .make()
        .paddingSymmetric(horizontal: 16);
  }
}

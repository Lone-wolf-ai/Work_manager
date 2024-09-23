import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:work_manger_tool/app/modules/user/profile/widget/customshimer.dart'; // Import this package

class ProfileTop extends StatelessWidget {
  const ProfileTop({
    super.key,
    this.imglink,
    this.name = '',
    this.id = '',
    required this.ontap,
  });

  final String? imglink;
  final String name;
  final String id;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[400],
          radius: 60,
          child: ClipOval(
            child: imglink != null
                ? CachedNetworkImage(
                    width: 120,
                    height: 120,
                    imageUrl: imglink!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CustomCircleShimmer(),
                    errorWidget: (context, url, error) => const Icon(Icons.person),
                  )
                : const Icon(Icons.person, size: 100, color: Vx.gray700),
          ),
        ).box
            .roundedFull
            
            .padding(const EdgeInsets.symmetric(vertical: 20)).border(color: Vx.gray400,width: 6)
            .make()
            .onTap(ontap),
        if (name != '') name.text.bold.capitalize.size(24).make(),
        if (id != '')
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "ID: ".text.size(18).bold.gray600.make(),
              id.text.size(16).semiBold.gray500.make(),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ID copied to clipboard')),
                  );
                },
                icon: const Icon(Iconsax.copy, size: 16),
              )
            ],
          ),
      ],
    ).centered();
  }
}

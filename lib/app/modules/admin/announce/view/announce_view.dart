import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class AnnounceView extends StatelessWidget {
  const AnnounceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        title: "Announce Page".text.bold.size(22).make(),
        backgroundColor: Vx.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.add5,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDD0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    "Title".text.gray600.size(24).bold.make(),
                  ],
                ),
                8.heightBox,
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                16.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    "Description".text.bold.gray600.size(24).make(),
                  ],
                ),
                8.heightBox,
                TextFormField(
                  decoration: InputDecoration(
                  
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  maxLines: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

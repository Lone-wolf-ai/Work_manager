import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminTaskView extends StatelessWidget {
  const AdminTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Vx.gray800,
        foregroundColor: Vx.white,
        child: const Icon(Icons.add),
      ),
        appBar: AppBar(
          title: "Admin Task View".text.bold.make(),
          backgroundColor: Vx.white,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Iconsax.activity), text: "Ongoing"),
              Tab(icon: Icon(Iconsax.task_square), text: "Pending"),
              Tab(icon: Icon(Iconsax.receipt_search), text: "Review"),
              Tab(icon: Icon(Icons.check_box_outlined), text: "Completed"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('Home Tab')),
            SingleChildScrollView(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(), 
                shrinkWrap: true, 
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return 10.heightBox;
                },
                itemBuilder: (BuildContext context, int index) {
                  return "Hello".text.make();
                },
              ),
            ),
            const Center(child: Text('')),
            const Center(child: Text('Settings Tab')),
          ],
        ),
      ),
    );
  }
}
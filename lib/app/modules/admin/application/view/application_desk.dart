import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/boxlistview.dart';

class ApplicationDesk extends StatelessWidget {
  const ApplicationDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Application Desk".text.bold.gray900.make(),
        automaticallyImplyLeading: true,
      ),
      body: BoxListView(),
    );
    
  }
}



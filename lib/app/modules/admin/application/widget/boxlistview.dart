import 'package:flutter/material.dart';
import '../../../../data/models/applicationmodel.dart';
import 'boxitemwidget.dart';

class BoxListView extends StatelessWidget {
  final List<BoxItem> items = List.generate(
    10,
    (index) => BoxItem(
      title: 'Title $index',
      date: DateTime.now().subtract(Duration(days: index)),
      description: 'Description for item $index',
    ),
  );

  BoxListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: BoxItemWidget(item: items[index]),
        );
      },
    );
  }
}

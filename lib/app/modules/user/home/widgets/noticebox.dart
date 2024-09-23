import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../data/models/noticemodel.dart';
import '../../notice/notice_view.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({
    super.key,
    required this.notice,
  });

  final Notice? notice;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            if (notice != null) {
              Get.to(() => NoticeView(notice: notice!));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              _buildDescription(),
            ],
          )
              .box
              .width(240)// Adjust width based on constraints
              .rounded
              .make()
              .p(4),
        );
      },
    );
  }

  Widget _buildTitle() {
    return (notice?.title ?? "No notice")
        .text
        .black
        .capitalize
        .size(20)
        .bold
        .make()
        .box
        .topRounded(value: 16)
        .width(double.infinity)
        .padding(const EdgeInsets.symmetric(horizontal: 10, vertical: 10))
        .gray300
        .make();
  }

  Widget _buildDescription() {
    return GestureDetector(
      onTap: () {
        if (notice != null) {
          Get.to(() => NoticeView(notice: notice!));
        }
      },
      child: (notice?.description ?? "")
          .text
          .ellipsis.medium
          .maxLines(3)
          .make()
          .box
          .padding(const EdgeInsets.only(bottom: 10, left: 10, right: 10))
          .gray300
          .bottomRounded(value: 16).height(60)
          .width(double.infinity)
          .make(),
    );
  }
}

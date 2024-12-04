import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:work_manger_tool/app/core/utils/constants/string_const.dart';
import 'package:work_manger_tool/app/core/utils/shimmer/customshimmer.dart';
import 'package:work_manger_tool/app/data/models/weathermodel.dart';
import 'package:work_manger_tool/app/data/service/api/weatherdata.dart';
import 'package:work_manger_tool/app/modules/user/home/controller/homecontroller.dart';
import '../../../../data/service/api/locationtimecontroller.dart';

class TimeAndDate extends StatelessWidget {
  const TimeAndDate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationTimeController());
    final homecon = Get.put(HomeController());
    final _iselevated = true.obs;

    return Obx(() {
      final datetime = controller.datetime.value;

      if (datetime == null || datetime.time == null) {
        return const Customshimmer();
      } else {
        return AnimatedPhysicalModel(
          shape: BoxShape.rectangle,
          elevation: _iselevated.value ? 32.0 : 0.0,
          color: Colors.white,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(16.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Container(
                  width: double.infinity,
                  height: 140,
                  alignment: Alignment.center,
                  child: (_iselevated.value)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            datetime.time!.text.size(32).bold.gray700.make(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                datetime.date!.text.semiBold.gray600.make(),
                                " - ".text.semiBold.size(18).gray500.make(),
                                datetime.dayOfWeek!.text.semiBold.gray500
                                    .size(18)
                                    .make(),
                              ],
                            ),
                            homecon.locationname.value.text.bold.gray900.size(12).make(),
                            2.heightBox,
                            "Tap Here here to see your weather info".text.blue600.semiBold.make()
                          ],
                        )
                      : Column(
                          children: [
                            "WeatherInfo of your Location"
                                .text
                                .bold
                                .gray800
                                .size(16)
                                .underline
                                .make(),
                            "Temperature: ${homecon.emptyWeathemodel.value.main.temp.toInt()}${StringConst.degree}"
                                .text
                                .sky600
                                .bold
                                .size(14)
                                .make(),
                            4.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(3, (index) {
                                var iconllist = [
                                  StringConst.clouds,
                                  StringConst.humidity,
                                  StringConst.windspeed
                                ];
                                var values = [
                                  "${homecon.emptyWeathemodel.value.clouds.all}",
                                  "${homecon.emptyWeathemodel.value.main.humidity}%",
                                  "${homecon.emptyWeathemodel.value.wind.speed}km/h"
                                ];
                                var valuetitle = [
                                  "Clouds",
                                  "Humidity",
                                  "Wind Speed"
                                ];
                                return Column(children: [
                                  Image.asset(
                                    iconllist[index],
                                    width: 32,
                                    height: 32,
                                  ).box.gray200.roundedSM.make(),
                                  values[index].text.make(),
                                  valuetitle[index].text.make()
                                ]);
                              }),
                            ),
                          ],
                        )
                          .box
                          .border(color: Vx.sky700, width: 4)
                          .rounded
                          .padding(const EdgeInsets.all(4))
                          .make())
              .onTap(() {
            _iselevated.value = !_iselevated.value;
          }),
          /*  */
        ).onTap(() {
          _iselevated.value = !_iselevated.value;
        });
      }
    });
  }
}


// getCurrentWeather(23.777176, 90.399452),
// AnimatedContainer(
// width: 200,
// height: 2,
// duration: const Duration(milliseconds: 500),
// decoration: BoxDecoration(
// color: Colors.red, borderRadius: BorderRadius.circular(12)),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// datetime.time!.text.size(32).bold.gray700.make(),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// datetime.date!.text.semiBold.gray600.make(),
// " - ".text.semiBold.size(18).gray500.make(),
// datetime.dayOfWeek!.text.semiBold.gray500.size(18).make(),
// ],
// ),
// ],
// ),
// )



// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// datetime.time!.text.size(32).bold.gray700.make(),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// datetime.date!.text.semiBold.gray600.make(),
// " - ".text.semiBold.size(18).gray500.make(),
// datetime.dayOfWeek!.text.semiBold.gray500.size(18).make(),
// ],
// ),
// ],
// )
//     .paddingSymmetric(horizontal: 10, vertical: 20)
//     .box
//     .width(double.infinity)
// .height(140)
// .make()


import 'package:about_worldskills/services/json_reader.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(),
          Text(
            "Statistic",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          ),
          Container(
            width: 20,
            height: 4,
            decoration: BoxDecoration(
              color: Color(0xffdd0a76),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xff003764),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      children: [
                        Text(
                          "The number of WorldSkills competitors",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder(
                          future: JsonReader.readStatistics(),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("loading data");
                            }
                            if (!asyncSnapshot.hasData) {
                              return Text("no data");
                            }
                            final List<Tween<double>> tweens = asyncSnapshot
                                .data!
                                .map((e) {
                                  return Tween<double>(
                                    begin: 0,
                                    end: double.parse(
                                      e["competitors"].toString(),
                                    ),
                                  );
                                })
                                .toList();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 32,
                              children: [
                                for (
                                  int i = 0;
                                  i < asyncSnapshot.data!.length;
                                  i++
                                )
                                  TweenAnimationBuilder(
                                    duration: 2.seconds,
                                    tween: tweens[i],
                                    builder: (context, value, child) {
                                      return Column(
                                        children: [
                                          Text(
                                            "${value.toInt()}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Container(
                                                height: Get.height / 2,
                                                width: 24,
                                                color: Color(0xff0f2846),
                                              ),
                                              Container(
                                                height:
                                                    (Get.height / 2) /
                                                    1500 *
                                                    value,
                                                width: 24,
                                                color: Color(0xff4783fa),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              "${asyncSnapshot.data![i]["competition"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 120,
                    child: Image.asset(
                      "assets/images/pattern-2.png",
                      repeat: ImageRepeat.repeatX,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

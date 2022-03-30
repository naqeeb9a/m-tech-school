import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/loaders.dart';
import '../utils/config.dart';
import 'package:html/parser.dart';

class NoticeSlider extends StatelessWidget {
  final String school, studentId;
  const NoticeSlider({Key? key, required this.school, required this.studentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List colors = [
      Colors.red,
      Colors.green,
      Colors.deepOrangeAccent,
      Colors.purple,
      Colors.teal,
    ];
    Random random = Random();
    return FutureBuilder(
      future: ApiData().getStudentDetails("notices", school, studentId),
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider(
            items: ((snapshot.data["data"]) as List).map((e) {
              index = random.nextInt(5);

              return Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: myGrey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500]!,

                          spreadRadius: 1,
                          blurRadius: 15,
                          offset:
                              const Offset(4, 4), // changes position of shadow
                        ),
                        const BoxShadow(
                          color: myWhite,
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: Offset(-4, -4), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colors[index],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500]!,

                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: const Offset(
                                4, 4), // changes position of shadow
                          ),
                          const BoxShadow(
                            color: myWhite,
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset:
                                Offset(-4, -4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e["date"],
                                style: TextStyle(
                                  color: myWhite,
                                  fontSize: dynamicWidth(context, 0.03),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                _parseHtmlString(e["title"])),
                                            content: HtmlWidget(e["notice"]),
                                          ));
                                },
                                child: Text("See More",
                                    style: TextStyle(
                                        color: myWhite,
                                        fontSize: dynamicWidth(context, 0.03),
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          Text(
                            _parseHtmlString(e["title"]),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: dynamicWidth(context, 0.05),
                                color: myWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "",
                            style: TextStyle(color: colors[index]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 5,
                      left: 0,
                      child: Image.asset(
                        "assets/notice.png",
                        width: dynamicWidth(context, 0.25),
                      ))
                ],
              );
            }).toList(),
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: false,
              viewportFraction: 0.8,
            ),
          );
        } else {
          return customLoader(context);
        }
      }),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}

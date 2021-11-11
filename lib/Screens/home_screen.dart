import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.03),
                vertical: dynamicHeight(context, 0.01)),
            child: header(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              categoryCard(
                  context,
                  0.35,
                  0.44,
                  0.33,
                  0.4,
                  Colors.lightBlue,
                  "LESSONS",
                  "123 Lessons 12 Subjects",
                  "assets/teacher.png",
                  0.2,
                  0.3),
              categoryCard(
                  context,
                  0.4,
                  0.44,
                  0.38,
                  0.4,
                  const Color(0xff2ca896),
                  "PRACTICE",
                  "123 practices 12 Example",
                  "assets/practice.png",
                  0.18,
                  0.5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              categoryCard(
                  context,
                  0.4,
                  0.44,
                  0.38,
                  0.4,
                  Colors.orange,
                  "PRACTICE",
                  "123 practices 12 Example",
                  "assets/games.png",
                  0.2,
                  0.6,
                  check: true),
              categoryCard(
                  context,
                  0.35,
                  0.44,
                  0.33,
                  0.4,
                  Colors.deepPurple,
                  "LESSONS",
                  "123 Lessons 12 Subjects",
                  "assets/homework.png",
                  0.2,
                  0.4,
                  check: true),
            ],
          )
        ],
      )),
    );
  }

  categoryCard(context, outerSizeH, outerSizeW, innerSizeH, innerSizeW,
      colorDynamic, text1, text2, image, imageH, imageW,
      {check = false}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: dynamicHeight(context, outerSizeH),
          width: dynamicWidth(context, outerSizeW),
        ),
        Container(
          height: dynamicHeight(context, innerSizeH),
          width: dynamicWidth(context, innerSizeW),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: colorDynamic),
          child: Padding(
            padding: EdgeInsets.all(dynamicWidth(context, 0.02)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: (check == false)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: dynamicHeight(context, 0.01),
                ),
                Text(
                  text1,
                  style: TextStyle(
                      fontSize: dynamicWidth(context, 0.04), color: myWhite),
                ),
                SizedBox(
                  height: dynamicHeight(context, 0.01),
                ),
                Text(
                  text2,
                  style: TextStyle(
                      fontSize: dynamicWidth(context, 0.03), color: myWhite),
                ),
                SizedBox(
                  height: dynamicHeight(context, 0.01),
                ),
              ],
            ),
          ),
        ),
        (check == false)
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  image,
                  height: dynamicHeight(context, imageH),
                  width: dynamicWidth(context, imageW),
                ),
              )
            : Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  image,
                  height: dynamicHeight(context, imageH),
                  width: dynamicWidth(context, imageW),
                ),
              )
      ],
    );
  }

  header(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "CATEGORIES",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: dynamicWidth(context, 0.05)),
        ),
        CircleAvatar(
          radius: dynamicWidth(context, 0.07),
          backgroundColor: Colors.black,
          backgroundImage: const NetworkImage(
              "https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg"),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

import 'config.dart';

categoryCard(context, outerSizeH, outerSizeW, innerSizeH, innerSizeW,
    colorDynamic, text1, text2, image, imageH, imageW,
    {check = false, function}) {
  return GestureDetector(
    onTap: function,
    child: Stack(
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
              borderRadius: BorderRadius.circular(15), color: colorDynamic),
          child: Padding(
            padding: EdgeInsets.all(dynamicWidth(context, 0.02)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: (check == false)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: dynamicHeight(context, 0.03),
                ),
                Text(
                  text1,
                  style: TextStyle(
                      fontSize: dynamicWidth(context, 0.05), color: myWhite),
                ),
                // SizedBox(
                //   height: dynamicHeight(context, 0.01),
                // ),
                // Text(
                //   text2,
                //   style: TextStyle(
                //       fontSize: dynamicWidth(context, 0.03), color: myWhite),
                // ),
                SizedBox(
                  height: dynamicHeight(context, 0.03),
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
    ),
  );
}

header(context, function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "ABEEHA HAIDER",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: dynamicWidth(context, 0.05)),
      ),
      GestureDetector(
        onTap: function,
        child: CircleAvatar(
          radius: dynamicWidth(context, 0.07),
          backgroundColor: Colors.black,
          backgroundImage: const NetworkImage(
              "https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg"),
        ),
      )
    ],
  );
}

functionalButtons(context, text, icon, color1, color2, {function}) {
  return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color1, color2]),
              borderRadius: BorderRadius.circular(5)),
          child: Container(
            width: dynamicWidth(context, 1),
            height: dynamicHeight(context, 0.07),
            alignment: Alignment.center,
            margin:
                EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: dynamicWidth(context, 0.04), color: myWhite),
                ),
                Icon(
                  icon,
                  color: myWhite,
                )
              ],
            ),
          )));
}

inputText(text, userCredentials, {password = false, function}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: function,
    obscureText: password,
    decoration: InputDecoration(labelText: text),
    onSaved: (value) {
      userCredentials.add(value);
    },
  );
}

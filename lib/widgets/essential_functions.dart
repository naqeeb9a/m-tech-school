import 'package:flutter/material.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

import '../utils/config.dart';

categoryCard(context, outerSizeH, outerSizeW, innerSizeH, innerSizeW,
    colorDynamic, text1, image, imageH, imageW,
    {check = false, function, dValue}) {
  Tween _scaleTween = Tween<double>(begin: 0.7, end: 1);
  return GestureDetector(
    onTap: function,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: dynamicHeight(context, outerSizeH),
          width: dynamicWidth(context, outerSizeW),
        ),
        TweenAnimationBuilder(
          duration: Duration(milliseconds: dValue),
          tween: _scaleTween,
          builder: (BuildContext context, dynamic scale, Widget? child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            height: dynamicHeight(context, innerSizeH),
            width: dynamicWidth(context, innerSizeW),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colorDynamic,
              boxShadow: [
                BoxShadow(
                  color: colorDynamic.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
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
                  SizedBox(
                    height: dynamicHeight(context, 0.03),
                  ),
                ],
              ),
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

header(context, userName, function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: dynamicWidth(context, 0.5),
        child: Text(
          userName.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            fontSize: dynamicWidth(context, 0.05),
          ),
        ),
      ),
      GestureDetector(
        onTap: function,
        child: CircleAvatar(
          radius: dynamicWidth(context, 0.07),
          backgroundColor: Colors.black,
          child: Icon(
            Icons.person,
            color: myWhite,
            size: dynamicWidth(context, 0.08),
          ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    child: Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color1, color2]),
          borderRadius: BorderRadius.circular(5)),
      child: Container(
        width: dynamicWidth(context, 1),
        height: dynamicHeight(context, 0.07),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
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
      ),
    ),
  );
}

inputText(text, userCredentials, {password = false, function}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textInputAction: TextInputAction.next,
    validator: function,
    obscureText: password,
    decoration: InputDecoration(labelText: text),
    onSaved: (value) {
      userCredentials.add(value);
    },
  );
}

bar(text, {check = false}) {
  return AppBar(
    title: Text(
      text,
      style: TextStyle(
        color: check == true ? myWhite : myBlack,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: (check == true) ? myWhite : myBlack),
    backgroundColor:
        check == true ? const Color(0xFFc7445c) : Colors.transparent,
    elevation: 0,
  );
}

eventPageCards(context, index, snapshot) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, 0.01),
      horizontal: dynamicWidth(context, 0.1),
    ),
    height: dynamicHeight(context, 0.224),
    decoration: BoxDecoration(
      color: primaryLiteOrange,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .04),
      ),
      boxShadow: [
        BoxShadow(
          color: myBlack.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: dynamicWidth(context, 1),
          height: dynamicHeight(context, .07),
          decoration: BoxDecoration(
            color: myBlack,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                dynamicWidth(context, .04),
              ),
              topLeft: Radius.circular(
                dynamicWidth(context, .04),
              ),
            ),
          ),
          child: Center(
            child: Text(
              snapshot.data["data"][index]["title"],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: myWhite,
                fontSize: dynamicWidth(context, 0.044),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: dynamicHeight(context, .006),
          ),
          child: SizedBox(
            height: dynamicHeight(context, 0.14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text("Classes"),
                    Text("Venue"),
                    Text("Start"),
                    Text("End"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(":"),
                    Text(":"),
                    Text(":"),
                    Text(":"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      snapshot.data["data"][index]["classes"],
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      snapshot.data["data"][index]["venue"],
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      snapshot.data["data"][index]["start_date_time"],
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      snapshot.data["data"][index]["end_date_time"],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget feeCards(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["data"].length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        decoration: BoxDecoration(
          color: primaryLiteGreen,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .04),
          ),
          boxShadow: [
            BoxShadow(
              color: myBlack.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, 0.014),
          horizontal: dynamicWidth(context, 0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: dynamicWidth(context, 1),
              height: dynamicHeight(context, .06),
              decoration: BoxDecoration(
                color: myBlack,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    dynamicWidth(context, .04),
                  ),
                  topLeft: Radius.circular(
                    dynamicWidth(context, .04),
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "Fee Challan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: myWhite,
                    fontSize: dynamicWidth(context, 0.044),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: dynamicHeight(context, 0.01),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, .05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Month : " +
                        monthName(
                          snapshot.data["data"][index]["month"].toString(),
                        ).toString(),
                  ),
                  Text(
                    "Year : " + snapshot.data["data"][index]["year"].toString(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: dynamicHeight(context, 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Amount : ",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Deduction : ",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Time Span : ",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  width: dynamicWidth(context, 0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data["data"][index]["amount"].toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        snapshot.data["data"][index]["deduction"].toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        snapshot.data["data"][index]["title"].toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: dynamicHeight(context, 0.01),
            ),
          ],
        ),
      );
    },
  );
}

dynamic monthName(month) {
  if (month == "12") {
    return "December";
  } else if (month == "11") {
    return "November";
  } else if (month == "10") {
    return "October";
  } else if (month == "9") {
    return "September";
  } else if (month == "8") {
    return "August";
  } else if (month == "7") {
    return "July";
  } else if (month == "6") {
    return "June";
  } else if (month == "5") {
    return "May";
  } else if (month == "4") {
    return "April";
  } else if (month == "3") {
    return "March";
  } else if (month == "2") {
    return "February";
  } else if (month == "1") {
    return "January";
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';

List<DateTime> presentDates = [
  DateTime(2021, 11, 1),
  DateTime(2021, 11, 3),
  DateTime(2021, 11, 4),
  DateTime(2021, 11, 5),
  DateTime(2021, 11, 6),
  DateTime(2021, 11, 9),
  DateTime(2021, 11, 10),
  DateTime(2021, 11, 11),
  DateTime(2021, 11, 15),
  DateTime(2021, 11, 22),
  DateTime(2021, 11, 23),
];
List<DateTime> absentDates = [
  DateTime(2021, 11, 2),
  DateTime(2021, 11, 7),
  DateTime(2021, 11, 8),
  DateTime(2021, 11, 12),
  DateTime(2021, 11, 13),
  DateTime(2021, 11, 14),
  DateTime(2021, 11, 16),
  DateTime(2021, 11, 17),
  DateTime(2021, 11, 18),
  DateTime(2021, 11, 19),
  DateTime(2021, 11, 20),
];

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _presentIcon(String day) => CircleAvatar(
          backgroundColor: primaryGreen,
          child: Text(
            day,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );

    Widget _absentIcon(String day) => CircleAvatar(
          backgroundColor: primaryPink,
          child: Text(
            day,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );

    EventList<Event> _markedDateMap = EventList<Event>(
      events: {},
    );

    CalendarCarousel _calendarCarouselNoHeader;

    var len = min(absentDates.length, presentDates.length);
    double cHeight;

    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        presentDates[i],
        Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        absentDates[i],
        Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: const TextStyle(
        color: primaryPink,
      ),
      weekdayTextStyle: const TextStyle(
        color: myBlack,
        fontWeight: FontWeight.bold,
      ),
      daysTextStyle: const TextStyle(color: myBlack),
      todayTextStyle: const TextStyle(
        color: myWhite,
      ),
      iconColor: myBlack,
      headerTextStyle: TextStyle(
        color: myBlack,
        fontSize: dynamicWidth(context, .05),
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 5,
      todayButtonColor: myBlack,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Attendance"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(true),
            child: Container(
              color: primaryPurple,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: dynamicWidth(context, .9),
                  height: dynamicHeight(context, .48),
                  decoration: BoxDecoration(
                    color: primaryLitePurple,
                    borderRadius: BorderRadius.circular(
                      dynamicWidth(context, .04),
                    ),
                  ),
                  child: Center(
                    child: _calendarCarouselNoHeader,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

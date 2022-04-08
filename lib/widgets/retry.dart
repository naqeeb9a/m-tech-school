import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  final dynamic setState;
  final Color color;
  final Color textColor;
  const Retry(
      {Key? key,
      required this.setState,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_outlined,
            size: 30,
            color: color,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color)),
              onPressed: () => setState(),
              child: Text(
                "Retry",
                style: TextStyle(color: textColor),
              )),
        ],
      ),
    );
  }
}

import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecieverMessage extends StatelessWidget {
  const RecieverMessage({super.key, required this.text, required this.time});
  final String text;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greyMessage,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              Text(timeago.format(DateTime.parse(time), locale: 'en'),
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.end),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  const MyMessage({super.key, required this.text, required this.time});
  final String text;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(text),
              Text(timeago.format(DateTime.parse(time), locale: 'en'),
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.start),
            ],
          ),
        ),
      ),
    );
  }
}

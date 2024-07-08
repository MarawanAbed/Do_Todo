import 'package:do_todo/Do_Todo/presentation/widgets/notification/row_details.dart';
import 'package:do_todo/core/helpers/helper_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key, required this.title, required this.body, required this.startTime, required this.endTime,});

  final String title;
  final String body;
  final String startTime;
  final String endTime;
  @override
  Widget build(BuildContext context) {
    final formattedStartTime = HelperMethods().formatDateTime(startTime);
    final formattedEndTime = HelperMethods().formatDateTime(endTime);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'You have a new notification',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowDetails(
                  body: title,
                  title: 'Title',
                  icon: CupertinoIcons.textbox,
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                RowDetails(
                  title: 'Description',
                  icon: Icons.note_alt_outlined,
                  body: body,
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                RowDetails(
                  title: 'Date',
                  icon: Icons.watch_later_outlined,
                  body: 'From $formattedStartTime to $formattedEndTime',
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}




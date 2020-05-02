import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({
    Key key,
    this.title,
    this.description,
    this.maxLines,
    this.aditional = const [],
    this.date,
    this.time,
    this.color,
  }) : super(key: key);

  final String title;
  final String date;
  final String time;
  final String description;
  final int maxLines;
  final Color color;
  final List<Widget> aditional;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 8, right: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            color: Colors.black26,
            offset: Offset(1, 2),
          )
        ],
        color: color ?? Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          AlertHeader(title: title, date: date, time: time),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              description ??
                  'The following video (recorded at slow speed) shows a typical example. Tapping the flippers in the center of the route flies them to the upper left corner of a new, blue route, at a smaller size. Tapping the flippers in the blue route (or using the device’s back-to-previous-route gesture) flies the flippers back to the original route.',
              style: Theme.of(context).textTheme.bodyText2,
              maxLines: maxLines,
              overflow: (maxLines != null ? TextOverflow.ellipsis : null),
            ),
          ),
          ...aditional,
        ],
      ),
    );
  }
}

class AlertHeader extends StatelessWidget {
  const AlertHeader({
    Key key,
    @required this.title,
    @required this.date,
    @required this.time,
  }) : super(key: key);

  final String title;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title ?? 'Title',
            style: Theme.of(context).textTheme.headline6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                date ?? '2020/04/10',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                time ?? '07:12PM',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )
        ],
      ),
    );
  }
}

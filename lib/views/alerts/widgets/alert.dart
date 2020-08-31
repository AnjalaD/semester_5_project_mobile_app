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
      margin: EdgeInsets.only(top: 16, left: 8, right: 8),
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
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          AlertHeader(title: title, date: date, time: time),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Text(
              description,
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
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                date,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.caption,
              ),
              // Text(
              //   time ?? '07:12PM',
              //   textAlign: TextAlign.right,
              //   style: Theme.of(context).textTheme.caption,
              // ),
            ],
          )
        ],
      ),
    );
  }
}

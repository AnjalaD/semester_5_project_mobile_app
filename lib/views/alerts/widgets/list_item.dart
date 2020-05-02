import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/views/alerts/view_alert.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    this.color,
    this.title,
    this.description,
    this.dateTime,
  }) : super(key: key);

  final Color color;
  final String title;
  final String description;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Feedback.forTap(context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewAlert(),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
        padding: EdgeInsets.all(12),
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
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Icon(Icons.ac_unit),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    dateTime,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

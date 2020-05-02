import 'package:flutter/material.dart';

class ChangeLocationRow extends StatelessWidget {
  const ChangeLocationRow({
    Key key,
    this.title,
    this.value,
    this.onChanged,
    this.refresh = false,
    this.onRefresh,
  }) : super(key: key);

  final bool refresh;
  final String title;
  final bool value;
  final Function onChanged;
  final Function onRefresh;

  List<Widget> _refreshButton() {
    List<Widget> row = [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
      Text(title),
    ];
    if (refresh) {
      row.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: !value ? () {} : onRefresh,
        ),
      ));
    }
    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(left: 60),
      child: Center(
        child: Row(
          children: _refreshButton(),
        ),
      ),
    );
  }
}

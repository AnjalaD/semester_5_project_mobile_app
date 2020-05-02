import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmgNumbers extends StatelessWidget {
  const EmgNumbers({
    Key key,
  }) : super(key: key);

  void callNumber(String number) async {
    final String url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "cannot launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            'Contact Numbers:',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () => callNumber('+94714137804'),
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(2),
                    child: Text(
                      '+94714137804',
                      style: Theme.of(context)
                          .textTheme
                          .apply(fontSizeDelta: 4)
                          .bodyText2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => callNumber('+94714137804'),
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(2),
                    child: Text(
                      '+94714137804',
                      style: Theme.of(context)
                          .textTheme
                          .apply(fontSizeDelta: 4)
                          .bodyText2,
                    ),
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

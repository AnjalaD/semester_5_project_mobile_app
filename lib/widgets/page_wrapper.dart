import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/services/messages.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper(
      {Key key,
      this.child,
      this.title,
      this.drawer,
      this.body,
      this.isLoading,
      this.appBarActions})
      : super(key: key);

  final String title;
  final Widget drawer;
  final Widget body;
  final bool isLoading;
  final Widget child;
  final List<Widget> appBarActions;

  @override
  Widget build(BuildContext context) {
    return Consumer2<Authentication, Messages>(
      builder: (context, value, messages, child) {
        bool loading = isLoading;
        if (isLoading == null) {
          loading = value != null && value.isLoading;
        }
        return LoadingOverlay(
          isLoading: loading,
          color: Colors.black,
          progressIndicator: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withOpacity(.8),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 4,
                    blurRadius: 4,
                    color: Colors.black26,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                Text(
                  'Loading...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      decoration: TextDecoration.none),
                )
              ],
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: appBarActions ?? [],
            ),
            drawer: drawer,
            body: Builder(
              builder: (context) {
                Future.delayed(Duration.zero, () {
                  if (messages.message != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(messages.message),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {
                          messages.close();
                        },
                      ),
                      duration: Duration(seconds: 5),
                    ));
                  }
                });
                return body;
              },
            ),
          ),
        );
      },
    );
  }
}

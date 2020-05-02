import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: appBarActions ?? [],
      ),
      drawer: drawer,
      body: Consumer<Authentication>(
        builder: (context, value, child) {
          bool loading = isLoading;
          if (isLoading == null) {
            loading = value != null && value.isLoading;
          }
          return LoadingOverlay(
            isLoading: loading,
            progressIndicator: CircularProgressIndicator(),
            child: body,
          );
        },
      ),
    );
  }
}

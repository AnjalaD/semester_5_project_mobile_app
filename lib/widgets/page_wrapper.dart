import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({Key key, this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(
      // builder: (_, auth, __) => LoaderOverlay(
      child: child,
      // useDefaultLoading: auth != null ? auth.isLoading : false,
      // overlayWidget: CircularProgressIndicator(),
      // overlayColor: Colors.black,
      // ),
    );
  }
}

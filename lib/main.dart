import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/auth_wrapper.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PageWrapper(
          child: AuthWrapper(),
        ),
      ),
    );
  }
}

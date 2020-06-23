import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/views/auth/register.dart';
import 'package:semester_5_project_mobile_app/views/auth/widgets/login_form.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nic = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  String error;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _loginHandler(Authentication auth) => () async {
        final FormState form = _formKey.currentState;
        if (form.validate()) {
          String err =
              await auth.signIn(nic: _nic.text, password: _password.text);
          if (err != null) {
            setState(() {
              error = err;
            });
          }
        }
      };

  @override
  Widget build(BuildContext context) {
    Authentication auth = Provider.of<Authentication>(context);
    return PageWrapper(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_add),
            label: Text('Register'),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Register()));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Welcome to Commhawk!',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 24),
                LoginForm(
                  formKey: _formKey,
                  nic: _nic,
                  password: _password,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    error != null ? "*$error" : '',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                CustomButton(
                  labelText: 'Login',
                  onPressed: _loginHandler(auth),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

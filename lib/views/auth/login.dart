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
  bool checked = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _loginHandler(Authentication auth) => () {
        final FormState form = _formKey.currentState;
        if (form.validate()) {
          auth.signIn(
              nic: _nic.text, password: _password.text, keepSignedIn: checked);
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => AlertsList()));
        }
      };

  @override
  Widget build(BuildContext context) {
    Authentication auth = Provider.of<Authentication>(context);
    return PageWrapper(
      title: 'Login',
      appBarActions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person_add),
          label: Text('Register'),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Register()));
          },
        )
      ],
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                LoginForm(
                  formKey: _formKey,
                  nic: _nic,
                  password: _password,
                ),
                CheckboxListTile(
                  dense: true,
                  title: Text('Keep logged in'),
                  value: checked,
                  onChanged: (state) {
                    setState(() {
                      checked = state;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CustomButton(
                  labelText: 'Login',
                  onPressed: _loginHandler(auth),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                  child: ButtonTheme(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      child: Text('Forgot Password?'),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/models/user_model.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/services/messages.dart';
import 'package:semester_5_project_mobile_app/views/auth/login.dart';
import 'package:semester_5_project_mobile_app/views/auth/widgets/register_form.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _nicNo = new TextEditingController();
  final TextEditingController _dob = new TextEditingController();
  final TextEditingController _teleNo = new TextEditingController();
  final TextEditingController _addressLine1 = new TextEditingController();
  final TextEditingController _addressLine2 = new TextEditingController();
  final TextEditingController _city = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _confirmPassword = new TextEditingController();
  String error;

  _registerHandler(Authentication auth, Messages messages) => () async {
        if (_formKey.currentState.validate()) {
          print('registring...');
          String err = await auth.register(
              user: new User(
            nic: _nicNo.text,
            firstName: _firstName.text,
            lastName: _lastName.text,
            email: _email.text,
            dob: _dob.text,
            telephoneNumber: _teleNo.text,
            addressLine1: _addressLine1.text,
            addressLine2: _addressLine2.text,
            city: _city.text,
            password: _password.text,
          ));

          if (err != null) {
            setState(() {
              error = err;
            });
          } else {
            messages.add('Registration Complete. Please Login');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          }
        }
      };

  @override
  Widget build(BuildContext context) {
    Authentication auth = Provider.of<Authentication>(context);
    Messages messages = Provider.of<Messages>(context);
    return PageWrapper(
      title: 'Register',
      appBarActions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('Login'),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
        )
      ],
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              RegisterForm(
                formKey: _formKey,
                firstName: _firstName,
                lastName: _lastName,
                nicNo: _nicNo,
                dob: _dob,
                email: _email,
                addressLine1: _addressLine1,
                addressLine2: _addressLine2,
                city: _city,
                teleNo: _teleNo,
                password: _password,
                confirmPassword: _confirmPassword,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  error != null ? "*$error" : '',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              CustomButton(
                labelText: 'Register',
                onPressed: _registerHandler(auth, messages),
              )
            ],
          ),
        ],
      ),
    );
  }
}

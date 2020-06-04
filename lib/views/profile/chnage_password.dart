import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/services/messages.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';
import 'package:semester_5_project_mobile_app/util/validators/form_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/match_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/min_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/password_validator.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_text_field.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _confirm = TextEditingController();

  Function _changePassword(Authentication auth, Messages messages) => () async {
        auth.isLoading = true;
        if (_formKey.currentState.validate()) {
          bool result = await ApiRequestHandler.changePassword(
            token: auth.proxyUser.token,
            nic: auth.user.nic,
            oldPassword: _oldPass.text,
            newPassword: _newPass.text,
          );
          if (result) {
            messages.add('Password Changed Successfully!');
            _oldPass.text = '';
            _newPass.text = '';
            _confirm.text = '';
          } else {
            messages.add('Old Password is Incorrect!');
          }
        }
        auth.isLoading = false;
      };

  @override
  Widget build(BuildContext context) {
    Authentication auth = Provider.of<Authentication>(context);
    Messages messages = Provider.of<Messages>(context);
    MatchVatidator passwordMatch = MatchVatidator(
      checkWith: _newPass.text,
      label: 'Password',
    );
    return PageWrapper(
      title: 'Edit Profile',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomTextField(
                labelText: 'Old Password',
                isPassword: true,
                textEditingController: _oldPass,
              ),
              CustomTextField(
                labelText: 'New Password',
                textEditingController: _newPass,
                isPassword: true,
                onChanged: (_) {
                  passwordMatch.checkWith = _newPass.text;
                },
                validator: Validator.validator(
                  [MinValidator(6), PasswordValidator()],
                ),
              ),
              CustomTextField(
                labelText: 'Re-Type New Password',
                textEditingController: _confirm,
                isPassword: true,
                validator: Validator.validator(
                  [
                    passwordMatch,
                  ],
                ),
              ),
              CustomButton(
                labelText: 'Change Password',
                onPressed: _changePassword(auth, messages),
              )
            ],
          ),
        ),
      ),
    );
  }
}

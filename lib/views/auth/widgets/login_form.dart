import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/util/validators/empty_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/form_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/nic_validator.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController nic,
    @required TextEditingController password,
  })  : _formKey = formKey,
        _nic = nic,
        _password = password,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nic;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            labelText: 'NIC',
            textEditingController: _nic,
            validator: Validator.validator(
              [
                NicValidator(),
              ],
            ),
          ),
          CustomTextField(
            labelText: 'Password',
            textEditingController: _password,
            isPassword: true,
            validator: Validator.validator([
              EmptyValidator(),
            ]),
          ),
        ],
      ),
    );
  }
}

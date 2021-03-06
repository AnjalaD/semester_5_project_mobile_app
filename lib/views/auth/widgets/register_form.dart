import 'package:flutter/material.dart';
import 'package:semester_5_project_mobile_app/util/validators/date_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/email_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/empty_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/form_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/match_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/min_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/nic_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/password_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/telephone_validator.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController firstName,
    @required TextEditingController lastName,
    @required TextEditingController nicNo,
    @required TextEditingController dob,
    @required TextEditingController email,
    @required TextEditingController addressLine1,
    @required TextEditingController addressLine2,
    @required TextEditingController city,
    @required TextEditingController teleNo,
    @required TextEditingController password,
    @required TextEditingController confirmPassword,
  })  : _formKey = formKey,
        _fistName = firstName,
        _lastName = lastName,
        _nicNo = nicNo,
        _dob = dob,
        _email = email,
        _addressLine1 = addressLine1,
        _addressLine2 = addressLine2,
        _city = city,
        _teleNo = teleNo,
        _password = password,
        _confirmPassword = confirmPassword,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _fistName;
  final TextEditingController _lastName;
  final TextEditingController _nicNo;
  final TextEditingController _dob;
  final TextEditingController _email;
  final TextEditingController _addressLine1;
  final TextEditingController _addressLine2;
  final TextEditingController _city;
  final TextEditingController _teleNo;
  final TextEditingController _password;
  final TextEditingController _confirmPassword;

  @override
  Widget build(BuildContext context) {
    MatchVatidator passwordMatchValidator =
        new MatchVatidator(checkWith: _password.text, label: 'Password');
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextField(
                    labelText: 'First Name',
                    textEditingController: _fistName,
                    validator: Validator.validator(
                      [EmptyValidator()],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: 'Last Name',
                    textEditingController: _lastName,
                    validator: Validator.validator(
                      [EmptyValidator()],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextField(
                    labelText: 'NIC No.',
                    textEditingController: _nicNo,
                    validator: Validator.validator(
                      [NicValidator()],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: 'Date of birth',
                    textEditingController: _dob,
                    hintText: 'YYYY-MM-DD',
                    validator: Validator.validator([EmptyValidator(), DateValidator()]),
                  ),
                ),
              ],
            ),
            CustomTextField(
              labelText: 'Email',
              textEditingController: _email,
              validator: Validator.validator(
                [EmailValidator()],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextField(
                    labelText: 'Address Line-1',
                    textEditingController: _addressLine1,
                    validator: Validator.validator(
                      [EmptyValidator()],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: 'Address Line-2',
                    textEditingController: _addressLine2,
                  ),
                ),
              ],
            ),
            CustomTextField(
              labelText: 'City',
              textEditingController: _city,
              validator: Validator.validator(
                [EmptyValidator()],
              ),
            ),
            CustomTextField(
              labelText: 'Telephone No.',
              textEditingController: _teleNo,
              validator: Validator.validator(
                [TelephoneValidator()],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextField(
                    labelText: 'Password',
                    textEditingController: _password,
                    isPassword: true,
                    onChanged: (val) {
                      passwordMatchValidator.checkWith = _password.text;
                    },
                    validator: Validator.validator(
                      [MinValidator(6), PasswordValidator()],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: 'Re-Type',
                    textEditingController: _confirmPassword,
                    isPassword: true,
                    validator: Validator.validator(
                      [
                        passwordMatchValidator,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

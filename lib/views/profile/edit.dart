import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/models/update_user_model.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/services/messages.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';
import 'package:semester_5_project_mobile_app/util/validators/email_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/empty_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/form_validator.dart';
import 'package:semester_5_project_mobile_app/util/validators/telephone_validator.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_text_field.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _addressLine1 = TextEditingController();
  final _addressLine2 = TextEditingController();
  final _city = TextEditingController();
  final _teleNo = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Authentication auth = Provider.of<Authentication>(context, listen: false);
      _email.text = auth.user.email;
      _addressLine1.text = auth.user.addressLine1;
      _addressLine2.text = auth.user.addressLine2;
      _city.text = auth.user.city;
      _teleNo.text = auth.user.telephoneNumber;
    });
  }

  void _saveChanges(Authentication auth, Messages messages) async {
    UpdateUser updateUser = new UpdateUser(
      addressLine1: _addressLine1.text,
      addressLine2: _addressLine2.text,
      city: _city.text,
      email: _email.text,
      telephoneNumber: _teleNo.text,
    );
    auth.isLoading = true;
    if (_formKey.currentState.validate()) {
      bool result = await ApiRequestHandler.updateUser(
          token: auth.proxyUser.token, user: updateUser);
      messages.add(
          result ? 'Profile Updated!' : 'Error occured, please try again!');
      if (result) {
        auth.updateUser(updateUser);
      }
    }
    auth.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    Authentication auth = Provider.of<Authentication>(context);
    Messages messages = Provider.of<Messages>(context);

    return PageWrapper(
      title: 'Edit Profile',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
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
                CustomButton(
                  labelText: 'Save & Update',
                  onPressed: () {
                    _saveChanges(auth, messages);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/services/messages.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';
import 'package:semester_5_project_mobile_app/views/auth/login.dart';
import 'package:semester_5_project_mobile_app/views/profile/chnage_password.dart';
import 'package:semester_5_project_mobile_app/views/profile/edit.dart';
import 'package:semester_5_project_mobile_app/views/profile/widgets/profile_row.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_text_field.dart';
import 'package:semester_5_project_mobile_app/widgets/drawer.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  void _confirmDelete(
      BuildContext context, Authentication auth, Messages messages) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final password = TextEditingController();
        return AlertDialog(
            title: Text('Confirm Account Delete'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomTextField(
                  labelText: 'Password',
                  isPassword: true,
                  textEditingController: password,
                ),
                CustomButton(
                  color: Colors.red,
                  labelText: 'Delete',
                  onPressed: () async {
                    bool res = await ApiRequestHandler.deleteUser(
                      token: auth.proxyUser.token,
                      nic: auth.user.nic,
                      password: password.text,
                    );
                    if (res) {
                      auth.signOut();
                      messages.add('Account Deleted!');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                      return;
                    }
                    messages.add('Error Occured, Please try again!');
                  },
                )
              ],
            ));
      },
    );
  }

  void _gotoPage(Widget page, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Profile',
      appBarActions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _gotoPage(EditProfile(), context),
        )
      ],
      drawer: CustomDrawer(),
      body: Consumer2<Authentication, Messages>(
        builder: (context, auth, messages, _) => ListView(
          children: <Widget>[
            Container(
              height: 140,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Center(
                child: Text(
                  "${auth.user.firstName} ${auth.user.lastName}",
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
            ),
            ProfileRow(
              name: 'Email',
              value: auth.user.email,
            ),
            ProfileRow(
              name: 'Address',
              value:
                  "${auth.user.addressLine1}, ${auth.user.addressLine2}, ${auth.user.city}}",
            ),
            ProfileRow(
              name: 'NIC number',
              value: auth.user.nic,
            ),
            ProfileRow(
              name: 'Telephone',
              value: auth.user.telephoneNumber,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  labelText: 'Change Password',
                  onPressed: () => _gotoPage(ChangePassword(), context),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  color: Colors.red,
                  labelText: 'Delete Account',
                  onPressed: () => _confirmDelete(context, auth, messages),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

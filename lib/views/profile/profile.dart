import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';
import 'package:semester_5_project_mobile_app/views/profile/chnage_password.dart';
import 'package:semester_5_project_mobile_app/views/profile/edit.dart';
import 'package:semester_5_project_mobile_app/views/profile/widgets/profile_row.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/drawer.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Profile',
      appBarActions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProfile(),
              ),
            );
          },
        )
      ],
      drawer: CustomDrawer(),
      body: Consumer<Authentication>(
        builder: (context, auth, _) => ListView(
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  color: Colors.red,
                  labelText: 'Delete Account',
                  onPressed: () async {
                    auth.isLoading = true;
                    bool result =
                        await ApiRequestHandler.deleteUser(token: 'sfass');
                    auth.isLoading = false;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

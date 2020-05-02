import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_5_project_mobile_app/services/authentication.dart';
import 'package:semester_5_project_mobile_app/views/profile/change_location.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/drawer.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Profile',
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
            ProfileRow(
              name: 'Location',
              value: auth.user.location == null
                  ? 'Please set your location'
                  : "Lat:${auth.user.location.latitude.toStringAsFixed(4)}," +
                      " Lng:${auth.user.location.longitude.toStringAsFixed(4)}",
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  labelText: 'Change Location',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeLocation(),
                      ),
                    );
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

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    Key key,
    this.name,
    this.value,
  }) : super(key: key);

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
            strutStyle: StrutStyle(leading: 0.4),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

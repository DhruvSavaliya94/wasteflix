import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 36, horizontal: 18),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 18),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('email'),
                  subtitle: Text('@gmail.com'),
                ),
                Divider(),
                ListTile(
                  title: Text('phone number'),
                  subtitle: Text('9428870602'),
                ),
                Divider(),
                ListTile(
                  title: Text('account type'),
                  subtitle: Text('Individual'),
                ),
                Divider(),
                ListTile(
                  title: Text('location'),
                  subtitle: Text('Sk'),
                ),
                Divider(),
                ListTile(
                  title: Text('Featured Ads'),
                  subtitle: Text('Unlimited'),
                ),
                Divider(),
                ListTile(
                  title: Text('Expiration Date'),
                  subtitle: Text('None'),
                ),
                Divider(),
                ListTile(
                  title: Text('3.493.939'),
                  subtitle: Text('Unlimited'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

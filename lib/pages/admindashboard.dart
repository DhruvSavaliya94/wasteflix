import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wasteflix/handler/Models.dart';
import 'package:wasteflix/handler/auth.dart';
import 'package:wasteflix/pages/pickup.dart';
import 'package:wasteflix/pages/pickupstatus.dart';
import 'package:wasteflix/pages/profile.dart';
import 'package:wasteflix/pages/request.dart';
import 'package:wasteflix/utils/constant.dart';
import 'package:wasteflix/utils/iconcontent.dart';
import '../utils/reusablecard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile.dart';
class AdminDashboard extends StatefulWidget {
  final Admin logedadmin;
  AdminDashboard({this.logedadmin});
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int uid;
  String name;
  String contact;
  String email;
  int role;
  @override
  void initState() {
    super.initState();
    updateUI(widget.logedadmin);
  }
  void updateUI(dynamic userData) {
    setState(() {
      this.uid=userData.id;
      this.name=userData.name;
      this.contact=userData.contact;
      this.email=userData.email;
      this.role=userData.role;
    });
  }

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.account_circle),
          title: const Text('Profile'),
          onTap: () => Navigator.of(context).push(_NewPage("Profile",widget.logedadmin)),
        ),
        ListTile(
          leading: Icon(Icons.app_registration),
          title: const Text('About'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Admin Dashboard'),
      ),

      //Hear is dashboard code
      //---------------------------------------------------------
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Requests(logedadmin: widget.logedadmin);
                            },
                          ),
                        );
                      },
                      colour: Colors.blue,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.truckLoading,
                        label: 'New Pickup Request',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return PickupStatusPage(widget.logeduser);
                        //     },
                        //   ),
                        // );
                      },
                      colour: colorCard,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.bullhorn,
                        label: 'Pickup Status',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return Login();
                        //     },
                        //   ),
                        // );
                      },
                      colour: colorCard,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.history,
                        label: 'Transaction',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return Login();
                        //     },
                        //   ),
                        // );
                      },
                      colour: colorCard,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.moneyBill,
                        label: 'Rate',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}

class _NewPage extends MaterialPageRoute<void> {
  _NewPage(String title,Admin uprofile)
      : super(builder: (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$title'),
          elevation: 1.0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 36, horizontal: 18),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 18),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.view_sidebar),
                      title: Text('User Id'),
                      subtitle: Text('${uprofile.id}'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_box),
                      title: Text('User Name'),
                      subtitle: Text('${uprofile.name}'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email'),
                      subtitle: Text('${uprofile.contact}'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone number'),
                      subtitle: Text('+91 ${uprofile.email}'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      title: Text('User Role'),
                      subtitle: Text('Admin'),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  });
}

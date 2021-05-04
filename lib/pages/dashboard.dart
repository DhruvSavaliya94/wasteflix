import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasteflix/handler/Models.dart';
import 'package:wasteflix/handler/auth.dart';
import 'package:wasteflix/pages/about.dart';
import 'package:wasteflix/pages/rewardsU.dart';
import 'package:wasteflix/pages/pickup.dart';
import 'package:wasteflix/pages/pickupstatus.dart';
import 'package:wasteflix/pages/profile.dart';
import 'package:wasteflix/pages/history.dart';
import 'package:wasteflix/pages/selectrole.dart';
import 'package:wasteflix/pages/wastecategory.dart';
import 'package:wasteflix/utils/constant.dart';
import 'package:wasteflix/utils/iconcontent.dart';
import '../utils/reusablecard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile.dart';

class Dashboard extends StatefulWidget {
  Dashboard({this.logeduser});
  final User logeduser;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int uid;
  String name;
  String contact;
  String email;

  @override
  void initState() {
    super.initState();
    updateUI(widget.logeduser);
  }
  void updateUI(dynamic userData) {
    setState(() {
      this.uid=userData.id;
      this.name=userData.name;
      this.contact=userData.contact;
      this.email=userData.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      accountEmail: Text(""),
      accountName: Text(""),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.account_circle),
          title: const Text('Profile'),
          onTap: () => Navigator.of(context).push(_NewPage("Profile",widget.logeduser)),
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet_rounded ),
          title: const Text('Rewards'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RewardsPage(widget.logeduser);
                },
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.app_registration),
          title: const Text('About'),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AboutPage();
                },
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SelectRolePage();
                },
              ),
            );
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('User Dashboard'),
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
                              return PickupPage(logeduser: widget.logeduser);
                            },
                          ),
                        );
                      },
                      colour: primaryColor,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.truckLoading,
                        label: 'Pickup Request',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PickupStatusPage(widget.logeduser);
                            },
                          ),
                        );
                      },
                      colour: primaryColor,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HistoryPage(widget.logeduser);
                            },
                          ),
                        );
                      },
                      colour: primaryColor,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.history,
                        label: 'History',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WasteCategory();
                            },
                          ),
                        );
                      },
                      colour: primaryColor,
                      cardChild: IconContent(
                        icon: Icons.ballot_rounded,
                        label: 'Waste Category',
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
  _NewPage(String title,User uprofile)
      : super(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
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
                    subtitle: Text('User'),
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

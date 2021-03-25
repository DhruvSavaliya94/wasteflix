import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasteflix/handler/auth.dart';
import 'package:wasteflix/pages/pickup.dart';
import 'package:wasteflix/pages/pickupstatus.dart';
import 'package:wasteflix/utils/constant.dart';
import 'package:wasteflix/utils/iconcontent.dart';
import '../utils/reusablecard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Dhruv Savaliya'),
      accountEmail: Text('dhruv.savaliiya@email.com'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(size: 42.0),
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text('A'),
        ),
        CircleAvatar(
          backgroundColor: Colors.red,
          child: Text('B'),
        )
      ],
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.account_circle),
          title: const Text('Profile'),
          onTap: () => Navigator.of(context).push(_NewPage("Profile")),
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet_rounded ),
          title: const Text('Wallet'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.app_registration),
          title: const Text('About'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {},
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Dashboard'),
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
                              return PickupPage();
                            },
                          ),
                        );
                      },
                      colour: Colors.blue,
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
                              return PickupStatusPage();
                            },
                          ),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                        );
                      },
                      colour: colorCard,
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
                              return Login();
                            },
                          ),
                        );
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
  _NewPage(String id)
      : super(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$id'),
        elevation: 1.0,
      ),
      body: Center(
        child: Text('$id'),
      ),
    );
  });
}
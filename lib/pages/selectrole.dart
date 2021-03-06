import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/custom_text.dart' as customText;
import '../handler/Models.dart';
import 'login.dart';
class SelectRolePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectRolePageState();
  }
}

class _SelectRolePageState extends State<SelectRolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Image(image: AssetImage('assets/logo.png')),
        ),
        title: Text('Waste Flix'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage('assets/logo.png'),
                height: getSize(context, 150),
              ),
              SizedBox(height: getSize(context, 70),),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.title.merge(TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w100,
                      )),
                      children: [
                        TextSpan(text: 'How would you like to use '),
                        customText.LogoText.textSpan(context)
                      ]
                  ),
                ),
              ),
              OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  title: Text('Continue as User'),
                  subtitle: Text('I am a household/office I have waste to dispose/recycle/declust'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(UserType.Client)
                  ),
                  );
                },
              ),
              SizedBox(height: 20,),
              OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  title: Text('Continue as Vendor'),
                  subtitle: Text('I am a waste collector/recycler'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(UserType.Admin)
                  ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
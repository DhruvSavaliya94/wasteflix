import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:wasteflix/handler/Models.dart';
class RewardsPage extends StatefulWidget {
  final User logeduser;
  RewardsPage(this.logeduser);
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  Future<List<Rewards>> userData;
  void initState(){
    super.initState();
    userData = _getRewards(widget.logeduser.id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Rewards"),
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context) ,
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Rewards>>(
            future: userData,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(snapshot.data[index].reid.toString()),
                      title: Text("RequestId: ${snapshot.data[index].rid}"),
                      subtitle: Text("Username: ${snapshot.data[index].uname}\nRewards name: ${snapshot.data[index].rname}\nPartner: ${snapshot.data[index].partner}\nOffer: ${snapshot.data[index].offer}"
                      ),
                      trailing: Text("\n${snapshot.data[index].vouc_code}",
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: (){
                        print("taped");
                        Clipboard.setData(new ClipboardData(text: snapshot.data[index].vouc_code)).then((value){
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content:Text("Coupon code copied to clipboard")));
                        });
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
Future<List<Rewards>> _getRewards(int uid) async {
  String url = "http://10.0.2.2/wasteflix-api/api/api.php?apicall=getRewards&uid="+uid.toString();
  http.Response data = await http.get(url);
  var jsonData = json.decode(data.body);
  List<Rewards> cust = [];
  for(var u in jsonData["Requests"]){
    Rewards rewards = Rewards(u["reid"], u["rid"], u["uname"], u["rname"], u["partner"], u["vouc_code"],u["offer"]);
    cust.add(rewards);
  }
  return cust;
}
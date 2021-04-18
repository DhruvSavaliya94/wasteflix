import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wasteflix/handler/Models.dart';
import 'package:http/http.dart' as http;

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  Future<List<Request>> userData;
  void initState(){
    super.initState();
    userData = _getRequest();
  }
  Future<List<Rewards>> rewardData;

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
          child: FutureBuilder<List<Request>>(
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
                      leading: Text(snapshot.data[index].rid.toString()),
                      title: Text("Category: ${snapshot.data[index].name}"),
                      subtitle: Text("Description: ${snapshot.data[index].description}\nCity: ${snapshot.data[index].city}\nDate: ${snapshot.data[index].date}\nQuantity: ${snapshot.data[index].qnty}\nStatus: ${snapshot.data[index].status}"
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(child: Text("Accept")),
                          PopupMenuItem(child: Text("Reject."))
                        ],
                      ),
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

Future<List<Request>> _getRequest() async {
  String url = "http://10.0.2.2/wasteflix-api/api/api.php?apicall=getAllRequest";
  http.Response data = await http.get(url);
  var jsonData = json.decode(data.body);
  List<Request> cust = [];
  for(var u in jsonData["Requests"]){
    Request requests = Request(u["rid"], u["uid"], u["description"], u["name"], u["city"], u["date"],u["qnty"],u["status"]);
    cust.add(requests);
  }
  return cust;
}
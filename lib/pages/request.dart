import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:wasteflix/handler/Models.dart';
class Requests extends StatefulWidget {
  final Admin logedadmin;
  Requests({this.logedadmin});
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  Future<List<Request>> userData;
  int _selectedIndex = 0;
  int selectedRid;
  int qn;
  void initState(){
    super.initState();
    userData = _getRequest();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Requests"),
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
                      selected: index == _selectedIndex,
                      trailing: PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(value: 1,child: Text("Accept")),
                          PopupMenuItem(value: 0,child: Text("Reject."))
                        ],
                        onSelected: (int value) async{
                          print('index is $value');
                          setState(() {
                            _selectedIndex = index;
                            selectedRid=snapshot.data[_selectedIndex].rid;
                            qn=snapshot.data[_selectedIndex].qnty;
                          });
                          print('Rid is $selectedRid');
                          print('Qnty is $qn');
                          if(_selectedIndex==0){
                            updateStatus(selectedRid, "Completed.");
                          }else{
                            updateStatus(selectedRid, "Rejected.");
                          }
                          _showDialog(context,"Status updated.");
                        }
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
  String url = "http://10.0.2.2/wasteflix-api/api/api.php?apicall=getAllSRequest";
  http.Response data = await http.get(url);
  var jsonData = json.decode(data.body);
  List<Request> cust = [];
  for(var u in jsonData["Requests"]){
    Request requests = Request(u["rid"], u["uid"], u["description"], u["name"], u["city"], u["date"],u["qnty"],u["status"]);
    cust.add(requests);
  }
  return cust;
}

Future<void> updateStatus(int id,String status) async{
  String url = "http://10.0.2.2/wasteflix-api/api/api.php?apicall=updateStatus&rid="+id.toString()+"&status="+status;
  http.Response data = await http.get(url);
  var jsonData = json.decode(data.body);
  print(jsonData);
  print(jsonData['message']);
  print(jsonData['requestId']);
  var rid,uid,name,partner,vouc_code,offer;
  var price=jsonData['requestDetails'][0]['price'];
  var qnt=jsonData['requestDetails'][0]['qnty'];
  int total = price*qnt;
  rid = jsonData['requestDetails'][0]['rid'];
  uid = jsonData['requestDetails'][0]['uid'];
  name = "Cashback Offer";
  partner = "Amazon";
  vouc_code = "GET"+total.toString();
  offer = "Recharge Cashback";
  if(status=="Completed."){
    creditRewards(id,rid,uid,name,partner,vouc_code,offer);
  }
}
Future<void> creditRewards(int id,var rid,var uid,var name,var partner,var vouc_code,var offer) async{
  String url = "http://10.0.2.2/wasteflix-api/api/api.php?apicall=creditRewards";
  Map<String,dynamic> data = {
    'rid': rid,
    'uid': uid,
    'name' : name,
    'partner': partner,
    'vouc_code': vouc_code,
    'offer': offer,
  };
  String body = json.encode(data);
  print(body);
  var dio = Dio();
  try {
    FormData formData = new FormData.fromMap(data);
    var response = await dio.post(url,data: formData);
    var jsonData = json.decode(response.data);
    String ms = jsonData["message"];
    print(ms);
  } catch (e) {
    print(e);
  }
}
void _showDialog(BuildContext context, String msg) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert!"),
        content: new Text(msg),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


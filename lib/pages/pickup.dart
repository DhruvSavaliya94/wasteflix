import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class PickupPage extends StatefulWidget {
  final logeduser;

  const PickupPage({this.logeduser});

  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  int userid;

  final _formKey = GlobalKey<FormState>();
  FormRequest _formRequest = new FormRequest();
  List<CategoryListItem> _categoryListItem;
  List<DropdownMenuItem<CategoryListItem>> _dropdownMenuItemsCategory;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedItemCategory;

  Future<List<CategoryListItem>> _getItemC() async {
    http.Response data = await http
        .get("http://10.0.2.2/wasteflix-api/api/api.php?apicall=getAllCategory");
    var jsonData = json.decode(data.body);
    List<CategoryListItem> cust = [];
    for (var u in jsonData["AllCategory"]) {
      CategoryListItem categoryListItem =
      CategoryListItem(u["cid"], u["name"],u["price"]);
      cust.add(categoryListItem);
    }
    setState(() {
      _dropDownMenuItems = cust
          .map((CategoryListItem value) => DropdownMenuItem(
        value: value.cid.toString(),
        child: Text(value.name),
      ))
          .toList();
    });
  }
  Future<bool> _AddRequest() async {
    Map<String, dynamic> data = {
      'wuid': _formRequest.uid,
      'wdisc': _formRequest.disc,
      'wcategory': _formRequest.wcategory,
      'wcity': _formRequest.city,
      'wdate': _formRequest.date,
      'wqnt': _formRequest.qnt,
      'status': _formRequest.status,
    };
    String body = json.encode(data);
    print(data);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post(
          "http://10.0.2.2/wasteflix-api/api/api.php?apicall=addReq",
          data: formData);
      var jsonData = json.decode(response.data);
      var d = jsonData["error"] == "false" ? true : false;
      String ms = jsonData["message"];
      _showDialog(context, ms);
    } catch (e) {
      print(e);
    }
    return false;
  }
  @override
  void initState() {
    super.initState();
    _getItemC();
    userid=widget.logeduser.id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Schedule Pickup'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: new ListView(
            padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            children: <Widget>[
              Center(
                  child: Text(
                    "Create Request",
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  )),
              TextFormField(
                decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Enter discription',
                    labelText: 'Discription'),
                inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please discription';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formRequest.disc = value;
                },
              ),
              ListTile(
                title: Text('Category:'),
                trailing: DropdownButton(
                  value: _selectedItemCategory,
                  hint: Text('Choose'),
                  onChanged: ((String newValue) {
                    setState(() {
                      _selectedItemCategory = newValue;
                      _formRequest.wcategory=int.parse(newValue);
                    });
                  }),
                  items: _dropDownMenuItems,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Enter City',
                    labelText: 'City'),
                inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter City';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formRequest.city = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    icon: const Icon(Icons.badge),
                    hintText: 'Enter quantity',
                    labelText: 'Quantity:'),
                keyboardType: TextInputType.number,
                inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formRequest.qnt = int.parse(value);
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _formRequest.uid=userid;
                          _formRequest.date="2020-07-20";
                          _formRequest.status=0;
                      });
                      print("Process data");
                      _formKey.currentState.save();
                      _AddRequest();
                    } else {
                      print('Error');
                    }
                  },
                  child: Text('SUBMIT'),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}



class CategoryListItem {
  int cid;
  String name;
  int price;
  CategoryListItem(this.cid, this.name, this.price);
}


class FormRequest{
  int uid;
  String disc;
  int wcategory;
  String city;
  String date;
  int qnt;
  int status;
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


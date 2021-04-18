import 'package:flutter/material.dart';
import 'package:wasteflix/handler/Models.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  final UserType userType;

  SignUpPage(this.userType);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpForm user = new SignUpForm();
  bool showPassword1 = true;
  bool showPassword2 = true;

  TextEditingController _passwordController = TextEditingController();

  Future<bool> UserSignup() async {
    Map<String,dynamic> data = {
      'uname': user.name,
      'ucontact': user.contact,
      'uemail' : user.email,
      'urole': user.usersrole,
      'upass': user.password
    };
    String body = json.encode(data);
    print(body);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post("http://10.0.2.2/wasteflix-api/api/api.php?apicall=register", data: formData);
      var jsonData = json.decode(response.data);
      var d = jsonData["error"]=="false" ? true : false;
      String ms = jsonData["message"];
      _showDialog(context,ms);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
  void initState() {
    super.initState();
    widget.userType==UserType.Client ? user.usersrole=0 : user.usersrole=1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Sign Up'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your full name is required';
                          }
                        },
                        onSaved: (String value) {
                          user.name = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your phone number is required';
                          } else if (!RegExp(r'^[0-9]+$')
                              .hasMatch(value.toLowerCase())) {
                            return 'Please enter a valid phone number';
                          }
                        },
                        onSaved: (String value) {
                          user.contact = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your email is required';
                          } else if (!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$')
                              .hasMatch(value.toLowerCase())) {
                            return 'Please enter a valid email';
                          }
                        },
                        onSaved: (String value) {
                          user.email = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                showPassword1 = !showPassword1;
                              });
                            },
                          ),
                        ),
                        obscureText: showPassword1,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your password is required';
                          }
                        },
                        onSaved: (String value) {
                          user.password = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                showPassword2 = !showPassword2;
                              });
                            },
                          ),
                        ),
                        obscureText: showPassword2,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Re-enter your password';
                          } else if (value != _passwordController.text) {
                            return "Passwords don't match";
                          }
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        color: primaryColor,
                        child: Text('Sign Up'),
                        onPressed: () async {
                          print(widget.userType);
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                              bool value = await UserSignup();
                              if(value==false){
                                Navigator.pop(context);
                              }
                            }
                            else {
                              // _signupVendor(model);
                            }
                          }
                      ),
                      FlatButton(
                        child: Text("Already have an account, Login"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm{
  String name;
  String contact;
  String email;
  int usersrole;
  String password;
}

void _showDialog(BuildContext context,String msg) {
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
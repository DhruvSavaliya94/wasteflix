import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wasteflix/handler/Models.dart';
import 'package:wasteflix/pages/admindashboard.dart';
import 'package:wasteflix/pages/dashboard.dart';
import '../pages/signup.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  final UserType userType;
  LoginPage(this.userType);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginForm _loginForm = LoginForm();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  myBool result = myBool.False;
  User user;
  int urole;
  Future<dynamic> UserLogin() async {
    Map<String, dynamic> data = {
      'uemail': _loginForm.email,
      'upassword': _loginForm.password,
    };
    String body = json.encode(data);
    print(body);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post(
          "http://10.0.2.2/wasteflix-api/api/api.php?apicall=login",
          data: formData);
      print(response.data);
      var jsonData = json.decode(response.data);
      dynamic d = jsonData["user"];

      user = new User(d["uid"], d["user_name"], d["user_contact"], d["user_email"], d["user_role"]);
      urole=d["user_role"];
      print(jsonData["error"]);
      print(jsonData["message"]);
      return jsonData["error"];
    } catch (e) {
      print(e);
    }
    return "true";
  }

  void initState() {
    super.initState();
    //print(widget.userType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.emailAddress,
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
                          _loginForm.email = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                        obscureText: showPassword,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your password is required';
                          }
                        },
                        onSaved: (String value) {
                          _loginForm.password = value;
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text('Forgot Password'),
                          onPressed: () {},
                        ),
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                                var value = await UserLogin();
                                print(urole);
                                if (value == false && urole==0) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Dashboard(logeduser: user),
                                    ),
                                  );
                                }else if(value == false && urole==1){
                                  Admin admin = Admin(user.id,user.name,user.contact,user.email,user.role);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AdminDashboard(logedadmin: admin),
                                    ),
                                  );
                                }else {
                                  _showDialog(context, "Something incorrect.");
                                }
                            }
                          }),
                      FlatButton(
                        child: Text("Don't have an account, Sign Up"),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SignUpPage(widget.userType),
                            ),
                          );
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

class LoginForm {
  String email;
  String password;
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

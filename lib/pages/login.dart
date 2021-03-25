import 'package:flutter/material.dart';
import 'package:wasteflix/handler/Models.dart';
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
  final Map<String, dynamic> _formData = {'email': '', 'password': ''};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = true;

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
                          _formData['email'] = value;
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
                          _formData['password'] = value;
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
                        child: Text('Login'),
                        onPressed: () {
                          // ignore: unrelated_type_equality_checks
                          if(widget.userType == UserType.Client){
                            print("Client");
                          }else{
                            print("Admin");
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Dashboard()
                          ),
                          );
                          // if(_formKey.currentState.validate()){
                          //   _formKey.currentState.save();
                          //   if (widget.userType == UserType.Client) {
                          //     _loginUser(model, UserType.Client, 'home');
                          //   } else {
                          //     _loginUser(model, UserType.Vendor, 'vendor_home');
                          //   }
                          // }
                        }
                      ),
                      FlatButton(
                        child: Text("Don't have an account, Sign Up"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => SignUpPage(UserType.Client)
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

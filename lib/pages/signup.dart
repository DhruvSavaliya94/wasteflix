import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'name': '',
    'phone': '',
    'email': '',
    'username': '',
    'password': '',
    'location': ''
  };

  bool showPassword1 = true;
  bool showPassword2 = true;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _locationFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          labelText: 'full name',
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
                          _formData['name'] = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'phone',
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
                          _formData['phone'] = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'email',
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
                          _formData['email'] = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your username is required';
                          }
                          /*else if(!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$').hasMatch(value.toLowerCase())){
                            return 'Please enter a valid username';
                          }*/
                        },
                        onSaved: (String value) {
                          _formData['username'] = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                          controller: _locationFieldController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            labelText: 'location',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            suffixIcon: Builder(
                              builder: (BuildContext context) =>
                                  GestureDetector(
                                child: Icon(Icons.my_location),
                                onTap: () {
                                  // model.getLocation().then((String location){
                                  //   if(location.length == 0)
                                  //     Scaffold.of(context).showSnackBar(SnackBar(
                                  //         content: Text("Can't obtain location at the moment"),
                                  //         duration: Duration(seconds: 3)
                                  //     ));
                                  //   setState(() {
                                  //     _locationFieldController.text = location;
                                  //   });
                                  // });
                                },
                              ),
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'password',
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
                          _formData['password'] = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'confirm password',
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
                      FlatButton(
                        child: Text("Already have an account, Login"),
                        onPressed: () {
                          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         LoginPage(widget.userType)), (Route route) => false);
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

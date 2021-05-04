import 'package:flutter/material.dart';
import 'package:wasteflix/handler/Models.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('About us'),
      ),
      body: Center(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Team Members",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(""),
                Text("Dhruv Savaliya 91700104054"),
                Text("Dipkumar Kheni 91700104045"),
                Text("Krushnarajsinh Jadeja 91700104046"),
                Text(""),
                Text("Major Project",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 20),),
                Text(""),
                Text("Waste Handling-WasteFlix")
              ]),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum UserType { Client, Admin }
enum myBool {True,False}
enum status {Pending,Processing,Completed}
class User{
  int id;
  String name;
  String contact;
  String email;

  User(this.id,this.name,this.contact,this.email);
}

class Admin{
  final int id;
  final String name;
  final String email;
  final String contact;

  Admin(this.id,this.name,this.email,this.contact);

}

class Request{
  final int rid;
  final int uid;
  final String description;
  final String name;
  final String city;
  final String date;
  final int qnty;
  final String status;

  Request(this.rid, this.uid, this.description, this.name, this.city, this.date, this.qnty, this.status);
}

const Color primaryColor = Color.fromRGBO(11, 184, 74, 0.6);
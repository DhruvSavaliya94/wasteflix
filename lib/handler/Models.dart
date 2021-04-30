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
  int role;
  User(this.id,this.name,this.contact,this.email,this.role);
}

class Admin{
  int id;
  String name;
  String email;
  String contact;
  int role;

  Admin(this.id,this.name,this.email,this.contact,this.role);

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
 class Rewards{
  final int reid;
  final int rid;
  final String uname;
  final String rname;
  final String partner;
  final String vouc_code;
  final String offer;

  Rewards(this.reid, this.rid, this.uname, this.rname, this.partner, this.vouc_code, this.offer);
 }
const Color primaryColor = Color.fromRGBO(8, 206, 82, 0.8);
const Color secondaryColor = Color.fromRGBO(131, 246, 140, 0.8);

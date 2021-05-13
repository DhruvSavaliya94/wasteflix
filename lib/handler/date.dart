import 'dart:convert';
import 'package:http/http.dart' as http;
class Date{
  String date;
  Date(){
    this.date=null;
  }
  Future<String> getDate() async{
    String url = "http://worldtimeapi.org/api/timezone/Asia/Kolkata";
    final response = await http.get(url);

    var responseData = json.decode(response.body);
    print(responseData["datetime"].substring(0,10));
    this.date = responseData["datetime"].substring(0,10);
    return this.date;
  }
}
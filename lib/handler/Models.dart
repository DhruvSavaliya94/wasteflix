enum UserType { Client, Admin }
class User{
  final int id;
  final String name;
  final String email;
  final String contact;

  User(this.id,this.name,this.email,this.contact);

}

class Admin{
  final int id;
  final String name;
  final String email;
  final String contact;

  Admin(this.id,this.name,this.email,this.contact);

}
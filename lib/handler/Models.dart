enum UserType { Client, Admin }

class User{
  final int id;
  final String name;
  final String contact;
  final String email;
  final int role;

  User(this.id,this.name,this.contact,this.email,this.role);
}

class Admin{
  final int id;
  final String name;
  final String email;
  final String contact;

  Admin(this.id,this.name,this.email,this.contact);

}
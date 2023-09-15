class User {
  String? id;
  String? username;
  String? email;
  String? hashed_password;
  String? pseudo;
  String? photo;
  String? phonenumber;
  String? ffelink;
  bool? isadmin;
  List<String>? horses;

  User({
    this.id,
    this.username,
    this.email,
    this.hashed_password,
    this.pseudo,
    this.photo,
    this.phonenumber,
    this.ffelink,
    this.isadmin,
    this.horses,
  });
}

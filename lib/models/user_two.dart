class User_two {
  String? uid;
  String? atcid;
  String? name;
  String? imageURL;
  String? tower;
  String? contactNo;
  String? email;
  String? password;
  String? conpassword;

  User_two(
      {this.uid,
      this.atcid,
      this.name,
      this.imageURL = 'assets/images/profile-picture.png',
      this.tower,
      this.contactNo,
      this.email,
      this.password,
      this.conpassword});

  User_two.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    atcid = json['atcid'];
    name = json['name'];
    imageURL = json['imageURL'];
    tower = json['tower'];
    contactNo = json['contactNo'];
    email = json['email'];
    password = json['password'];
    conpassword = json['conpassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['atcid'] = atcid;
    data['name'] = name;
    data['imageURL'] = imageURL;
    data['tower'] = tower;
    data['contactNo'] = contactNo;
    data['email'] = email;
    data['password'] = password;
    data['conpassword'] = conpassword;
    return data;
  }
}

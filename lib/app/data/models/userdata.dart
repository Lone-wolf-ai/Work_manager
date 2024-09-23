class UserModel {
  String name;
  String id;
  String? phonenumber;
  String? address;
  String? profilepic;
  String email;
  String fullname;

  UserModel({
    required this.name,
    required this.id,
    this.phonenumber,
    this.address,
    this.profilepic,
    required this.email,
    required this.fullname,
  });

  // Create a UserModel from a JSON object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      id: json['id'],
      phonenumber: json['phonenumber'],
      address: json['address'],
      profilepic: json['profilepic'],
      email: json['email'],
      fullname: json['fullname'],
    );
  }

  // Convert a UserModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'phonenumber': phonenumber,
      'address': address,
      'profilepic': profilepic,
      'email': email,
      'fullname': fullname,
    };
  }
}

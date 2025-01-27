
class UserModel{
  final String uId;
  final String userName;
  final String email;
  final String phone;
  final String userImg;
  final String userDeviceToken;
  final String userCity;
  final String country;
  final String userAddress;
  final String street;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;

  UserModel({
    required this.uId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.userImg,
    required this.userDeviceToken,
    required this.userCity,
    required this.country,
    required this.userAddress,
    required this.street,
    required this.isAdmin,
    required this.isActive,
    required this.createdOn,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String,dynamic> toMap(){
    return {
      'uId': uId,
      'userName': userName,
      'email': email,
      'phone': phone,
      'userImg': userImg,
      'userDeviceToken': userDeviceToken,
      'city': userCity,
      'country': country,
      'userAddress': userAddress,
      'street':street,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdOn': createdOn,
    };
  }
  // Create a UserModel instance from a JSON map
  factory UserModel.fromMap(Map<String,dynamic> json){
    return UserModel(
      uId: json['uId'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      userImg: json['userImg'],
      userDeviceToken: json['userDeviceToken'],
      userCity: json['userCity'],
      country: json['country'],
      userAddress: json['userAddress'],
      street: json['street'],
      isAdmin: json['isAdmin'],
      isActive: json['isActive'],
      createdOn: json['createdOn'],
    );
  }

}
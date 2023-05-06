import 'package:softech_hustlers/enum/account_type.dart';

class UserModel {
  final String userName;
  final AccountType accountType;
  final String email;
  final int? cnic;
  final bool emailVerified;
  final bool? verified;
  final String? phoneNo;
  final String? location;
  final double? lng;
  final double? lat;
  final String? profileImgUrl;
  final String? serviceCategory;

  const UserModel({
    required this.userName,
    required this.accountType,
    required this.email,
    required this.emailVerified,
    this.cnic,
    this.verified,
    this.phoneNo,
    this.location,
    this.lng,
    this.lat,
    this.profileImgUrl,
    this.serviceCategory
  });




  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'accountType': accountType.name,
      'email': email,
      'cnic': cnic,
      'verified': verified,
      'emailVerified': emailVerified,
      'location': location,
      'phoneNo': phoneNo,
      'lng': lng,
      'lat': lat,
      'profileImgUrl':profileImgUrl,
      'serviceCategory':serviceCategory,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      accountType: AccountType.values.firstWhere((element) => element.name==map['accountType']),
      email: map['email'] as String,
      cnic: (int.tryParse(map['cnic'] ?? '0') ?? 0),
      verified: (map['verified'] ?? false) as bool,
      emailVerified: (map['emailVerified'] ?? false) as bool,
      phoneNo: map['phoneNo'],
      location: map['location'],
      lat: map['lat'],
      lng: map['lng'],
      profileImgUrl: map['profileImgUrl'],
      serviceCategory: map['serviceCategory']
    );
  }

}
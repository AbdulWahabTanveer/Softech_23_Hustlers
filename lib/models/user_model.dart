import 'package:softech_hustlers/enum/account_type.dart';
import 'package:softech_hustlers/models/review_model.dart';

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
  final List<dynamic>? serviceCategory;
  final String? id;
  List<ReviewModel> reviewModel;

  UserModel({
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
    this.serviceCategory,
    this.id,
    this.reviewModel = const [],
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
      'profileImgUrl': profileImgUrl,
      'serviceCategory': serviceCategory,
      'id': id,
      'reviews': reviewModel.map((e) => e.toJson())
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userName: map['userName'] as String,
        accountType: AccountType.values
            .firstWhere((element) => element.name == map['accountType']),
        email: map['email'] as String,
        cnic: (int.tryParse(map['cnic'] ?? '0') ?? 0),
        verified: (map['verified'] ?? false) as bool,
        emailVerified: (map['emailVerified'] ?? false) as bool,
        phoneNo: map['phoneNo'],
        location: map['location'],
        lat: map['lat'],
        lng: map['lng'],
        profileImgUrl: map['profileImgUrl'],
        serviceCategory: map['serviceCategory'] ?? [],
        id: map['id'],
        reviewModel: ((map['reviews'] ?? []) as List)
            .map((e) => ReviewModel.fromJson(e))
            .toList());
  }
}

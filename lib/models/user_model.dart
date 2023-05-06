import 'package:softech_hustlers/enum/account_type.dart';

class UserModel {
  final String userName;
  final AccountType accountType;
  final String email;
  final int? cnic;
  final bool emailVerified;
  final bool? verified;

  const UserModel({
    required this.userName,
    required this.accountType,
    required this.email,
    required this.emailVerified,
    this.cnic,
    this.verified,
  });




  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'accountType': accountType.name,
      'email': email,
      'cnic': cnic,
      'verified': verified,
      'emailVerified': emailVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      accountType: AccountType.values.firstWhere((element) => element.name==map['accountType']),
      email: map['email'] as String,
      cnic: map['cnic'] as int,
      verified: map['verified'] as bool,
      emailVerified: map['emailVerified'] as bool,

    );
  }

}
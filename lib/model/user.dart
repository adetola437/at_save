import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id? id;  //isar auti id
  String uid;  //uid of the user
  String name;  //full name of the user
  String email;  //email of the user
  String phoneNumber;  //phone number of the user

  double? totalBalance;  //total balance of the user

  double? savingsBalance;  //total savings balance of the user

  double? walletBalance;  //wallet balance of the user

  User({
    required this.phoneNumber,
    this.id,
    this.savingsBalance = 0,
    this.walletBalance = 0,
    this.totalBalance = 0,
    required this.uid,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phoneNumber: json['phone_number'],
      totalBalance: json['total_balance'] != null
          ? json['total_balance'].toDouble()
          : null,
      savingsBalance: json['savings_balance'] != null
          ? json['savings_balance'].toDouble()
          : null,
      walletBalance: json['wallet_balance'] != null
          ? json['wallet_balance'].toDouble()
          : null,
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_balance': totalBalance,
      'savings_balance': savingsBalance,
      'wallet_balance': walletBalance,
      'phone_number': phoneNumber,
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}

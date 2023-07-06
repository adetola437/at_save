import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id? id;
  String uid;
  String name;
  String email;
  String phoneNumber;
  @ignore
  num totalBalance;
  @ignore
  num savingsBalance;
  @ignore
  num walletBalance;

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
      totalBalance: json['total_balance'],
      savingsBalance: json['savings_balance'],
      walletBalance: json['wallet_balance'],
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
      'phone_number':phoneNumber,
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}

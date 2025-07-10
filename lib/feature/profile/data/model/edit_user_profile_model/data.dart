import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String? name;
  final String? phone;
  final String? bio;
  final String? email;
  final String? otp;
  final String? wallet;
  final String? image;
  final dynamic token;

  const Data({
    this.name,
    this.bio,
    this.phone,
    this.email,
    this.otp,
    this.wallet,
    this.image,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        bio: json['bio'] as String?,
        email: json['email'] as String?,
        otp: json['otp'] as String?,
        wallet: json['wallet'] as String?,
        image: json['image'] as String?,
        token: json['token'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'bio': bio,
        'otp': otp,
        'wallet': wallet,
        'image': image,
        'token': token,
      };

  @override
  List<Object?> get props {
    return [name, phone, email, otp, bio, wallet, image, token];
  }
}

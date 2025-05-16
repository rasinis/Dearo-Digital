// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/customer_profile.dart';

class ResponseUserRegister{
  final bool error;
  final String message;
  final String action;
  final String? token;
  final String? first_name;
  final String? last_name;
  final CustomerProfile? customer_profile;

  ResponseUserRegister({
    required this.error,
    required this.message,
    required this.action,
    this.token,
    this.first_name,
    this.last_name,
    this.customer_profile
  });

  factory ResponseUserRegister.fromJson(Map<String, dynamic> json){
    late ResponseUserRegister responseUserRegister;

    try{
      responseUserRegister = ResponseUserRegister(
        error: json['error'],
        message: json['message'],
        action: json['action'],
        token: json['token'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        customer_profile: CustomerProfile.fromJson(json['customer_profile'])
      );

      return responseUserRegister;
    }catch(e){
      return ResponseUserRegister(
        error: true,
        message: e.toString(),
        action: "NA",
      );
    }
  }
}
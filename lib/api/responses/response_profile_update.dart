// ignore_for_file: non_constant_identifier_names

import '../../models/data/customer_profile.dart';

class ResponseProfileUpdate{
  final bool error;
  final String message;
  final CustomerProfile? customer_profile;

  ResponseProfileUpdate({
    required this.error,
    required this.message,
    required this.customer_profile
  });

  factory ResponseProfileUpdate.fromJson(Map<String, dynamic> json){
    late ResponseProfileUpdate responseProfileUpdate;

    try{
      responseProfileUpdate = ResponseProfileUpdate(
        error: json['error'],
        message: json['message'],
        customer_profile: CustomerProfile.fromJson(json['customer_profile']),
      );

      return responseProfileUpdate;
    }catch(e){
      return ResponseProfileUpdate(
        error: true,
        message: e.toString(),
        customer_profile: null,
      );
    }
  }
}
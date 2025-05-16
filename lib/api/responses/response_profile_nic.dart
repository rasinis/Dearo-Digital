// ignore_for_file: non_constant_identifier_names

import '../../models/data/customer_profile.dart';

class ResponseProfileNic{
  final bool error;
  final String message;
  final CustomerProfile? customer_profile;
  final String? nic_side;

  ResponseProfileNic({
    required this.error,
    required this.message,
    required this.customer_profile,
    required this.nic_side,
  });

  factory ResponseProfileNic.fromJson(Map<String, dynamic> json){
    late ResponseProfileNic responseProfileNic;

    try{
      responseProfileNic = ResponseProfileNic(
        error: json['error'],
        message: json['message'],
        customer_profile: CustomerProfile.fromJson(json['customer_profile']),
        nic_side: json['nic_side']
      );

      return responseProfileNic;
    }catch(e){
      return ResponseProfileNic(
        error: true,
        message: e.toString(),
        customer_profile: null,
        nic_side: null
      );
    }
  }
}
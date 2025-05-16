// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/inquiry_pawning.dart';

class ResponsePawningDetails{
  final bool error;
  final String message;
  final InquiryPawning? pawning_inquiry;

  ResponsePawningDetails({
    required this.error,
    required this.message,
    required this.pawning_inquiry
  });

  factory ResponsePawningDetails.fromJson(Map<String, dynamic> json){
    late ResponsePawningDetails responsePawningDetails;

    try{
      responsePawningDetails = ResponsePawningDetails(
        error: json['error'],
        message: json['message'],
        pawning_inquiry: InquiryPawning.fromJson(json['pawning_inquiry']),
      );

      return responsePawningDetails;
    }catch(e){
      return ResponsePawningDetails(
          error: true,
          message: e.toString(),
          pawning_inquiry: null
      );
    }
  }
}
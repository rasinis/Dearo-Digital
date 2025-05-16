// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/inquiry_pawning.dart';

import '../../models/data/inquiry_record.dart';

class ResponseSubmitPawning{
  final bool error;
  final String message;
  final InquiryPawning? inquiry_pawning;
  final InquiryRecord? inquiry_info;

  ResponseSubmitPawning({
    required this.error,
    required this.message,
    required this.inquiry_pawning,
    required this.inquiry_info
  });

  factory ResponseSubmitPawning.fromJson(Map<String, dynamic> json){
    late ResponseSubmitPawning responseSubmitPawning;

    try{
      responseSubmitPawning = ResponseSubmitPawning(
        error: json['error'],
        message: json['message'],
        inquiry_pawning: InquiryPawning.fromJson(json['inquiry_lease']),
        inquiry_info: InquiryRecord.fromJson(json['inquiry_info']),
      );

      return responseSubmitPawning;
    }catch(e){
      return ResponseSubmitPawning(
          error: true,
          message: e.toString(),
          inquiry_pawning: null,
          inquiry_info: null
      );
    }
  }
}
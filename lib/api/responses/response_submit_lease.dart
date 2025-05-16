// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/inquiry_record.dart';

import '../../models/data/inquiry_lease.dart';

class ResponseSubmitLease{
  final bool error;
  final String message;
  final InquiryLease? inquiry_lease;
  final InquiryRecord? inquiry_info;

  ResponseSubmitLease({
    required this.error,
    required this.message,
    required this.inquiry_lease,
    required this.inquiry_info
  });

  factory ResponseSubmitLease.fromJson(Map<String, dynamic> json){
    late ResponseSubmitLease responseSubmitLease;

    try{
      responseSubmitLease = ResponseSubmitLease(
        error: json['error'],
        message: json['message'],
        inquiry_lease: InquiryLease.fromJson(json['inquiry_lease']),
        inquiry_info: InquiryRecord.fromJson(json['inquiry_info']),
      );

      return responseSubmitLease;
    }catch(e){
      return ResponseSubmitLease(
        error: true,
        message: e.toString(),
        inquiry_lease: null,
        inquiry_info: null
      );
    }
  }
}
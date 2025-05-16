// ignore_for_file: non_constant_identifier_names

import '../../models/data/inquiry_insuarance.dart';

import '../../models/data/inquiry_record.dart';

class ResponseSubmitInsurance{
  final bool error;
  final String message;
  final InquiryInsurance? inquiry_insurance;
  final InquiryRecord? inquiry_info;

  ResponseSubmitInsurance({
    required this.error,
    required this.message,
    required this.inquiry_insurance,
    required this.inquiry_info
  });

  factory ResponseSubmitInsurance.fromJson(Map<String, dynamic> json){
    late ResponseSubmitInsurance responseSubmitInsurance;

    try{
      responseSubmitInsurance = ResponseSubmitInsurance(
        error: json['error'],
        message: json['message'],
        inquiry_insurance: InquiryInsurance.fromJson(json['inquiry_lease']),
        inquiry_info: InquiryRecord.fromJson(json['inquiry_info']),
      );

      return responseSubmitInsurance;
    }catch(e){
      return ResponseSubmitInsurance(
          error: true,
          message: e.toString(),
          inquiry_insurance: null,
          inquiry_info: null
      );
    }
  }
}
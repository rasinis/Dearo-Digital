import 'package:dearo_app/models/data/inquiry_record.dart';

class ResponseInquiries{
  final bool error;
  final String message;
  final List<InquiryRecord>? inquiries;

  ResponseInquiries({
    required this.error,
    required this.message,
    required this.inquiries
  });

  factory ResponseInquiries.fromJson(Map<String, dynamic> json){
    late Iterable list;
    try{
      list = json['inquiries'];
    }catch(e){
      //throw Exception("Not an array");
    }
    late ResponseInquiries responseInquiries;

    try{
      responseInquiries = ResponseInquiries(
        error: json['error'],
        message: json['message'],
        inquiries: list.map((item) => InquiryRecord.fromJson(item)).toList(),
      );

      return responseInquiries;
    }catch(e){
      return ResponseInquiries(
          error: true,
          message: "Something went wrong. Please check your internet connection...",
          inquiries: null
      );
    }
  }
}
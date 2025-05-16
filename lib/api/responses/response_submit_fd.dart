// ignore_for_file: non_constant_identifier_names

import '../../models/data/inquiry_fd.dart';
import '../../models/data/inquiry_record.dart';

class ResponseSubmitFd{
  final bool error;
  final String message;
  final InquiryFd? inquiry_fd;
  final InquiryRecord? inquiry_info;

  ResponseSubmitFd({
    required this.error,
    required this.message,
    required this.inquiry_fd,
    required this.inquiry_info
  });

  factory ResponseSubmitFd.fromJson(Map<String, dynamic> json){
    late ResponseSubmitFd responseSubmitFd;

    try{
      responseSubmitFd = ResponseSubmitFd(
        error: json['error'],
        message: json['message'],
        inquiry_fd: InquiryFd.fromJson(json['inquiry_fd']),
        inquiry_info: InquiryRecord.fromJson(json['inquiry_info']),
      );

      return responseSubmitFd;
    }catch(e){
      return ResponseSubmitFd(
          error: true,
          message: e.toString(),
          inquiry_fd: null,
          inquiry_info: null
      );
    }
  }
}
// ignore_for_file: non_constant_identifier_names

import '../../models/data/inquiry_fd.dart';

class ResponseFdDetails{
  final bool error;
  final String message;
  final InquiryFd? fd_inquiry;

  ResponseFdDetails({
    required this.error,
    required this.message,
    required this.fd_inquiry
  });

  factory ResponseFdDetails.fromJson(Map<String, dynamic> json){
    late ResponseFdDetails responseFdDetails;

    try{
      responseFdDetails = ResponseFdDetails(
        error: json['error'],
        message: json['message'],
        fd_inquiry: InquiryFd.fromJson(json['fd_inquiry']),
      );

      return responseFdDetails;
    }catch(e){
      return ResponseFdDetails(
          error: true,
          message: e.toString(),
          fd_inquiry: null
      );
    }
  }
}
// ignore_for_file: non_constant_identifier_names

class ResponseInquiryInitiated{
  final bool error;
  final String message;
  final int? inquiry_id;
  final String? inquiry_type;

  ResponseInquiryInitiated({
    required this.error,
    required this.message,
    required this.inquiry_id,
    required this.inquiry_type
  });

  factory ResponseInquiryInitiated.fromJson(Map<String, dynamic> json){
    late ResponseInquiryInitiated responseInquiryInitiated;

    try{
      responseInquiryInitiated = ResponseInquiryInitiated(
        error: json['error'],
        message: json['message'],
        inquiry_id: json['inquiry_id'],
        inquiry_type: json['inquiry_type'],
      );

      return responseInquiryInitiated;
    }catch(e){
      return ResponseInquiryInitiated(
          error: true,
          message: e.toString(),
          inquiry_id: null,
          inquiry_type: null
      );
    }
  }
}

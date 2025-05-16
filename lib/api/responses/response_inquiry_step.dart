// ignore_for_file: non_constant_identifier_names

class ResponseInquiryStep{
  final bool error;
  final String message;
  final int inquiry_id;
  final String inquiry_step;
  final bool is_passed;

  ResponseInquiryStep({
    required this.error,
    required this.message,
    required this.inquiry_id,
    required this.inquiry_step,
    required this.is_passed
  });

  factory ResponseInquiryStep.fromJson(Map<String, dynamic> json){
    late ResponseInquiryStep responseInquiryStep;

    try{
      responseInquiryStep = ResponseInquiryStep(
        error: json['error'],
        message: json['message'],
        inquiry_id: json['inquiry_id'],
        inquiry_step: json['inquiry_step'],
        is_passed: json['is_passed'],
      );

      return responseInquiryStep;
    }catch(e){
      return ResponseInquiryStep(
          error: true,
          message: e.toString(),
          inquiry_id: 0,
          inquiry_step: '',
          is_passed: false
      );
    }
  }
}
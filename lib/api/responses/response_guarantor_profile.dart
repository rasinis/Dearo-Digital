// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/guarantor_profile.dart';

class ResponseGuarantorProfile{
  final bool error;
  final String message;
  final GuarantorProfile? guarantor_profile;

  ResponseGuarantorProfile({
    required this.error,
    required this.message,
    required this.guarantor_profile
  });

  factory ResponseGuarantorProfile.fromJson(Map<String, dynamic> json){
    late ResponseGuarantorProfile responseGuarantorProfile;

    try{
      responseGuarantorProfile = ResponseGuarantorProfile(
        error: json['error'],
        message: json['message'],
        guarantor_profile: GuarantorProfile.fromJson(json['guarantor_profile']),
      );

      return responseGuarantorProfile;
    }catch(e){
      return ResponseGuarantorProfile(
          error: true,
          message: e.toString(),
          guarantor_profile: null
      );
    }
  }
}
// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/billing_proof.dart';

class ResponseBillingProof{
  final bool error;
  final String message;
  final String? bill_name;
  final String? bill_type;
  final BillingProof? billing_proof;

  ResponseBillingProof({
    required this.error,
    required this.message,
    required this.bill_name,
    required this.bill_type,
    required this.billing_proof
  });

  factory ResponseBillingProof.fromJson(Map<String, dynamic> json){
    late ResponseBillingProof responseBillingProof;

    try{
      responseBillingProof = ResponseBillingProof(
        error: json['error'],
        message: json['message'],
        bill_name: json['bill_name'],
        bill_type: json['bill_type'],
        billing_proof: BillingProof.fromJson(json['billing_proof']),
      );

      return responseBillingProof;
    }catch(e){
      return ResponseBillingProof(
          error: true,
          message: e.toString(),
          bill_name: null,
          bill_type: null,
          billing_proof: null
      );
    }
  }

  get inquiry_step => null;

  bool? get is_passed => null;
}
// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/inquiry_fd.dart';
import 'package:dearo_app/models/data/inquiry_lease.dart';
import 'package:dearo_app/models/data/inquiry_insuarance.dart';
import 'package:dearo_app/models/data/inquiry_pawning.dart';

class InquiryRecord{
  final int id;
  final int customer_id;
  final String inquiry_type;
  final String inquiry_status;
  final int reference_inquiry_id;
  final DateTime created_at;
  final DateTime updated_at;
  final dynamic inquiry_info;factory InquiryRecord.fromJson(Map<String, dynamic>json){
    switch(json['inquiry_type']){
      case 'LEASE':
        return InquiryRecord(
          id: json['id'],
          customer_id: json['customer_id'],
          inquiry_type: json['inquiry_type'],
          inquiry_status: json['inquiry_status'],
          reference_inquiry_id: json['reference_inquiry_id'],
          created_at: DateTime.parse(json['created_at']),
          updated_at: DateTime.parse(json['updated_at']),
          inquiry_info: InquiryLease.fromJson(json['inquiry_info']),
        );
      case 'FD':
        return InquiryRecord(
          id: json['id'],
          customer_id: json['customer_id'],
          inquiry_type: json['inquiry_type'],
          inquiry_status: json['inquiry_status'],
          reference_inquiry_id: json['reference_inquiry_id'],
          created_at: DateTime.parse(json['created_at']),
          updated_at: DateTime.parse(json['updated_at']),
          inquiry_info: InquiryFd.fromJson(json['inquiry_info']),
        );
      case 'INSURANCE':
        return InquiryRecord(
          id: json['id'],
          customer_id: json['customer_id'],
          inquiry_type: json['inquiry_type'],
          inquiry_status: json['inquiry_status'],
          reference_inquiry_id: json['reference_inquiry_id'],
          created_at: DateTime.parse(json['created_at']),
          updated_at: DateTime.parse(json['updated_at']),
          inquiry_info: InquiryInsurance.fromJson(json['inquiry_info']),
        );
      case 'PAWNING':
        return InquiryRecord(
          id: json['id'],
          customer_id: json['customer_id'],
          inquiry_type: json['inquiry_type'],
          inquiry_status: json['inquiry_status'],
          reference_inquiry_id: json['reference_inquiry_id'],
          created_at: DateTime.parse(json['created_at']),
          updated_at: DateTime.parse(json['updated_at']),
          inquiry_info: InquiryPawning.fromJson(json['inquiry_info']),
        );
    }

    return InquiryRecord(
      id: json['id'],
      customer_id: json['customer_id'],
      inquiry_type: json['inquiry_type'],
      inquiry_status: json['inquiry_status'],
      reference_inquiry_id: json['reference_inquiry_id'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      inquiry_info: null,
    );
  }

  InquiryRecord({
    required this.id,
    required this.customer_id,
    required this.inquiry_type,
    required this.inquiry_status,
    required this.reference_inquiry_id,
    required this.created_at,
    required this.updated_at,
    required this.inquiry_info
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customer_id,
      'inquiry_type': inquiry_type,
      'inquiry_status': inquiry_status,
      'reference_inquiry_id': reference_inquiry_id,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  @override
  String toString() {
    return 'InquiryRecord{id: $id, customer_id: $customer_id, inquiry_type: $inquiry_type, inquiry_status: $inquiry_status, reference_inquiry_id: $reference_inquiry_id, created_at: $created_at, updated_at: $updated_at,}';
  }

  // Removed duplicate factory constructor
}
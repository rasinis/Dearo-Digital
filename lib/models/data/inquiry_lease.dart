// ignore_for_file: non_constant_identifier_names

class InquiryLease{
  final int id;
  final String inquiry_step;
  final int vehicle_id;
  final int guarantor_id;
  final int? guarantor2_id;
  final bool is_arrears;
  final bool vehicle_missing;
  final DateTime created_at;
  final DateTime updated_at;

  InquiryLease({
    required this.id,
    required this.inquiry_step,
    required this.vehicle_id,
    required this.guarantor_id,
    required this.guarantor2_id,
    required this.is_arrears,
    required this.vehicle_missing,
    required this.created_at,
    required this.updated_at
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'inquiry_step':inquiry_step,
      'vehicle_id':vehicle_id,
      'guarantor_id':guarantor_id,
      'guarantor2_id':guarantor2_id,
      'is_arrears':is_arrears,
      'vehicle_missing':vehicle_missing,
      'created_at':created_at,
      'updated_at':updated_at
    };
  }

  @override
  String toString() {
    return 'InquiryLease{id:$id, inquiry_step:$inquiry_step, vehicle_id:$vehicle_id, guarantor_id:$guarantor_id, guarantor2_id:$guarantor2_id, is_arrears:$is_arrears, vehicle_missing:$vehicle_missing, created_at:$created_at, updated_at:$updated_at}';
  }

  factory InquiryLease.fromJson(Map<String, dynamic>json){
    return InquiryLease(
      id: json['id'],
      inquiry_step: json['inquiry_step'],
      vehicle_id: json['vehicle_id'],
      guarantor_id: json['guarantor_id'],
      guarantor2_id: json['guarantor2_id'],
      is_arrears: json['is_arrears'],
      vehicle_missing: json['vehicle_missing'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at'])
    );
  }
}
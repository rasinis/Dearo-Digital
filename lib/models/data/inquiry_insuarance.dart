// ignore_for_file: non_constant_identifier_names

class InquiryInsurance{
  final int id;
  final String inquiry_step;
  final int vehicle_id;
  final DateTime created_at;
  final DateTime updated_at;

  InquiryInsurance({
    required this.id,
    required this.inquiry_step,
    required this.vehicle_id,
    required this.created_at,
    required this.updated_at
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'inquiry_step':inquiry_step,
      'vehicle_id':vehicle_id,
      'created_at':created_at,
      'updated_at':updated_at
    };
  }

  @override
  String toString() {
    return '{id:$id, inquiry_step:$inquiry_step, vehicle_id:$vehicle_id, created_at:$created_at, updated_at:$updated_at}';
  }

  factory InquiryInsurance.fromJson(Map<String, dynamic>json){
    return InquiryInsurance(
        id: json['id'],
        inquiry_step: json['inquiry_step'],
        vehicle_id: json['vehicle_id'],
        created_at: DateTime.parse(json['created_at']),
        updated_at: DateTime.parse(json['updated_at'])
    );
  }
}
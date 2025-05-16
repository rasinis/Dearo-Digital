// ignore_for_file: non_constant_identifier_names

class InquiryPawning{
  final int id;
  final String inquiry_step;
  final bool pawned_elsewhere;
  final String? pic_pawned_receipt_elsewhere;
  final bool is_jewellery_added;
  final String amount;
  final DateTime created_at;
  final DateTime updated_at;

  InquiryPawning({
    required this.id,
    required this.inquiry_step,
    required this.pawned_elsewhere,
    required this.pic_pawned_receipt_elsewhere,
    required this.is_jewellery_added,
    required this.amount,
    required this.created_at,
    required this.updated_at
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'inquiry_step':inquiry_step,
      'pawned_elsewhere':pawned_elsewhere,
      'pic_pawned_receipt_elsewhere':pic_pawned_receipt_elsewhere,
      'is_jewellery_added':is_jewellery_added,
      'amount':amount,
      'created_at':created_at,
      'updated_at':updated_at
    };
  }

  @override
  String toString() {
    return '{id:$id, inquiry_step:$inquiry_step, pawned_elsewhere:$pawned_elsewhere, pic_pawned_receipt_elsewhere:$pic_pawned_receipt_elsewhere, is_jewellery_added:$is_jewellery_added, amount:$amount, created_at:$created_at, updated_at:$updated_at}';
  }

  factory InquiryPawning.fromJson(Map<String, dynamic>json){
    return InquiryPawning(
      id: json['id'],
      inquiry_step: json['inquiry_step'],
      pawned_elsewhere: json['pawned_elsewhere'],
      pic_pawned_receipt_elsewhere: json['pic_pawned_receipt_elsewhere'],
      is_jewellery_added: json['is_jewellery_added'],
      amount: json['amount'].toString(),
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at'])
    );
  }
}
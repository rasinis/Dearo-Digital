// ignore_for_file: non_constant_identifier_names

class InquiryFd{
  final int id;
  final String inquiry_step;
  final int? amount;
  final String? period;
  final String? preferred_rate;
  final bool is_completed;
  final DateTime created_at;
  final DateTime updated_at;

  InquiryFd({
    required this.id,
    required this.inquiry_step,
    required this.amount,
    required this.period,
    required this.preferred_rate,
    required this.is_completed,
    required this.created_at,
    required this.updated_at
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'inquiry_step':inquiry_step,
      'amount':amount,
      'period':period,
      'preferred_rate':preferred_rate,
      'is_completed':is_completed,
      'created_at':created_at,
      'updated_at':updated_at
    };
  }

  @override
  String toString() {
    return '{id:$id, inquiry_step:$inquiry_step, amount:$amount, period:$period, preferred_rate:$preferred_rate, is_completed:$is_completed, created_at:$created_at, updated_at:$updated_at}';
  }

  factory InquiryFd.fromJson(Map<String, dynamic>json){
    return InquiryFd(
        id: json['id'],
        inquiry_step: json['inquiry_step'],
        amount: json['amount'],
        period: json['period'],
        preferred_rate: json['preferred_rate'].toString(),
        is_completed: (json['is_completed'] == 1)?true:false,
        created_at: DateTime.parse(json['created_at']),
        updated_at: DateTime.parse(json['updated_at'])
    );
  }
}
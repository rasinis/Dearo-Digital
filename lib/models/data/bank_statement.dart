// ignore_for_file: non_constant_identifier_names

class BankStatement{
  final int id;
  final String owner_type;
  final int? customer_id;
  final int? guarantor_id;
  final DateTime statement_start_date;
  final DateTime statement_end_date;
  final String statement_file;

  BankStatement({
    required this.id,
    required this.owner_type,
    this.customer_id,
    this.guarantor_id,
    required this.statement_start_date,
    required this.statement_end_date,
    required this.statement_file
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_type': owner_type,
      'customer_id': customer_id,
      'guarantor_id': guarantor_id,
      'statement_start_date': statement_start_date,
      'statement_end_date': statement_end_date,
      'statement_file': statement_file
    };
  }

  @override
  String toString() {
    return 'BankStatement{id: $id, owner_type: $owner_type, customer_id: $customer_id, guarantor_id: $guarantor_id, statement_start_date: $statement_start_date, statement_end_date: $statement_end_date, statement_file: $statement_file}';
  }

  factory BankStatement.fromJson(Map<String, dynamic>json){
    return BankStatement(
      id: json['id'],
      owner_type: json['owner_type'],
      customer_id: json['customer_id'],
      guarantor_id: json['guarantor_id'],
      statement_start_date: DateTime.parse(json['statement_start_date']),
      statement_end_date: DateTime.parse(json['statement_end_date']),
      statement_file: json['statement_file']
    );
  }
}
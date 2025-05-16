// ignore_for_file: non_constant_identifier_names

class BillingProof{
  final String owner_type;
  final int? customer_id;
  final int? guarantor_id;
  final String proof_type;
  final String title;
  final String document_file;

  BillingProof({
    required this.owner_type,
    this.customer_id,
    this.guarantor_id,
    required this.proof_type,
    required this.title,
    required this.document_file
  });

  Map<String, dynamic> toMap() {
    return {
      'owner_type': owner_type,
      'customer_id': customer_id,
      'guarantor_id': guarantor_id,
      'proof_type': proof_type,
      'title': title,
      'document_file': document_file
    };
  }

  @override
  String toString() {
    return 'BillingProof{owner_type: $owner_type, customer_id: $customer_id, guarantor_id: $guarantor_id, proof_type: $proof_type, title: $title, document_file: $document_file}';
  }

  factory BillingProof.fromJson(Map<String, dynamic>json){
    return BillingProof(
        owner_type: json['owner_type'],
        customer_id: json['customer_id'],
        guarantor_id: json['guarantor_id'],
        proof_type: json['proof_type'],
        title: json['title'],
        document_file: json['document_file']
    );
  }
}
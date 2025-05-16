// ignore_for_file: non_constant_identifier_names

class GuarantorProfile{
  final int customer_id;
  final int inquiry_id;
  final int lease_inquiry_id;
  final bool is_first;
  final String first_name;
  final String last_name;
  final String nic;
  final String? pic_nic_front;
  final String? pic_nic_back;
  final String occupation;
  final String? email;
  final String contact_number;
  final String address;
  final int district_id;

  GuarantorProfile({
    required this.customer_id,
    required this.inquiry_id,
    required this.lease_inquiry_id,
    required this.is_first,
    required this.first_name,
    required this.last_name,
    required this.nic,
    this.pic_nic_front,
    this.pic_nic_back,
    required this.occupation,
    this.email,
    required this.contact_number,
    required this.address,
    required this.district_id
  });

  Map<String, dynamic> toMap() {
    return {
      'customer_id': customer_id,
      'inquiry_id': inquiry_id,
      'lease_inquiry_id': lease_inquiry_id,
      'is_first': is_first,
      'first_name': first_name,
      'last_name': last_name,
      'nic': nic,
      'pic_nic_front': pic_nic_front,
      'pic_nic_back': pic_nic_back,
      'occupation': occupation,
      'email': email,
      'contact_number': contact_number,
      'address': address,
      'district_id': district_id
    };
  }

  @override
  String toString() {
    return 'GuarantorProfile{customer_id: $customer_id, inquiry_id: $inquiry_id, lease_inquiry_id: $lease_inquiry_id, is_first: $is_first, first_name: $first_name, last_name: $last_name, nic: $nic, pic_nic_front: $pic_nic_front, pic_nic_back: $pic_nic_back, occupation: $occupation, email: $email, contact_number: $contact_number, address: $address, district_id: $district_id}';
  }

  factory GuarantorProfile.fromJson(Map<String, dynamic>json){
    return GuarantorProfile(
      customer_id: json['customer_id'],
      inquiry_id: json['inquiry_id'],
      lease_inquiry_id: json['lease_inquiry_id'],
      is_first: json['is_first'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      nic: json['nic'],
      pic_nic_front: json['pic_nic_front'],
      pic_nic_back: json['pic_nic_back'],
      occupation: json['occupation'],
      email: json['email'],
      contact_number: json['contact_number'],
      address: json['address'],
      district_id: json['district_id']
    );
  }

}
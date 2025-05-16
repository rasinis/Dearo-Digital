// ignore_for_file: non_constant_identifier_names

class CustomerProfile{
  final String first_name;
  final String last_name;
  final String? email;
  final String mobile_number;
  final DateTime? dob;
  final String? address;
  final int? district;
  final String? nic;
  final String? pic_nic_front;
  final String? pic_nic_back;
  final bool? is_completed;

  CustomerProfile({
      required this.first_name,
      required this.last_name,
      this.email,
      required this.mobile_number,
      this.dob,
      this.address,
      this.district,
      this.nic,
      this.pic_nic_front,
      this.pic_nic_back,
      this.is_completed
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'mobile_number': mobile_number,
      'dob': dob?.toIso8601String(),
      'address': address,
      'district': district,
      'nic': nic,
      'pic_nic_front': pic_nic_front,
      'pic_nic_back': pic_nic_back,
      'is_completed': is_completed,
    };
  }

  @override
  String toString() {
    return 'CustomerProfile{first_name:$first_name,last_name:$last_name,email:$email,mobile_number:$mobile_number,dob:$dob,address:$address,district:$district,nic:$nic,pic_nic_front:$pic_nic_front,pic_nic_back:$pic_nic_back,is_completed:$is_completed}';
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name':first_name,
      'last_name':last_name,
      'email':email,
      'mobile_number':mobile_number,
      'dob':dob,
      'address':address,
      'district':district,
      'nic':nic,
      'pic_nic_front':pic_nic_front,
      'pic_nic_back':pic_nic_back,
      'is_completed':is_completed
    };
  }

  factory CustomerProfile.fromJson(Map<String, dynamic>json){
    return CustomerProfile(
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      mobile_number: json['mobile_number'],
      dob: (json['dob'] != null)?DateTime.parse(json['dob']):null,
      address: json['address'],
      district: json['district'],
      nic: json['nic'],
      pic_nic_front: json['pic_nic_front'],
      pic_nic_back: json['pic_nic_back'],
      is_completed: json['is_completed'],
      // is_completed: (json['is_completed'] == 1)?true:false,
    );
  }

  bool isEssentialsCompleted(){
    if(district == null) return false;
    if(address == null) return false;
    if(dob == null) return false;
    if(nic == null) return false;
    if(pic_nic_front == null) return false;
    if(pic_nic_back == null) return false;

    return true;
  }
}
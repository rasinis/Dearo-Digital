// ignore_for_file: non_constant_identifier_names

class VehicleRecord {
  bool is_registered;
  String chassis_number;
  String engine_number;
  String engine_capacity;
  String? number_plate;
  String? registered_year;
  String make;
  String model;
  String manufactured_year;
  int? meter_reading;
  int? seating_capacity;
  String? pic_registration_certificate;
  String? pic_lessee_and_vehicle;
  String? pic_vehicle_front;
  String? pic_vehicle_rear;
  String? pic_vehicle_left;
  String? pic_vehicle_right;
  String? pic_meter_reading;
  String? pic_engine_number;
  String? pic_chassis_number;
  String? insurance_valuation;
  String? lease_valuation;
  bool? is_completed;

  VehicleRecord({
    required this.is_registered,
    required this.chassis_number,
    required this.engine_number,
    required this.engine_capacity,
    this.number_plate,
    this.registered_year,
    required this.make,
    required this.model,
    required this.manufactured_year,
    this.meter_reading,
    this.seating_capacity,
    this.pic_registration_certificate,
    this.pic_lessee_and_vehicle,
    this.pic_vehicle_front,
    this.pic_vehicle_rear,
    this.pic_vehicle_left,
    this.pic_vehicle_right,
    this.pic_meter_reading,
    this.pic_engine_number,
    this.pic_chassis_number,
    this.insurance_valuation,
    this.lease_valuation,
    this.is_completed,
  });

  /// Allows updating fields without modifying the whole object.
  VehicleRecord copyWith({
    bool? is_registered,
    String? chassis_number,
    String? engine_number,
    String? engine_capacity,
    String? number_plate,
    String? registered_year,
    String? make,
    String? model,
    String? manufactured_year,
    int? meter_reading,
    int? seating_capacity,
    String? pic_registration_certificate,
    String? pic_lessee_and_vehicle,
    String? pic_vehicle_front,
    String? pic_vehicle_rear,
    String? pic_vehicle_left,
    String? pic_vehicle_right,
    String? pic_meter_reading,
    String? pic_engine_number,
    String? pic_chassis_number,
    String? insurance_valuation,
    String? lease_valuation,
    bool? is_completed,
  }) {
    return VehicleRecord(
      is_registered: is_registered ?? this.is_registered,
      chassis_number: chassis_number ?? this.chassis_number,
      engine_number: engine_number ?? this.engine_number,
      engine_capacity: engine_capacity ?? this.engine_capacity,
      number_plate: number_plate ?? this.number_plate,
      registered_year: registered_year ?? this.registered_year,
      make: make ?? this.make,
      model: model ?? this.model,
      manufactured_year: manufactured_year ?? this.manufactured_year,
      meter_reading: meter_reading ?? this.meter_reading,
      seating_capacity: seating_capacity ?? this.seating_capacity,
      pic_registration_certificate: pic_registration_certificate ?? this.pic_registration_certificate,
      pic_lessee_and_vehicle: pic_lessee_and_vehicle ?? this.pic_lessee_and_vehicle,
      pic_vehicle_front: pic_vehicle_front ?? this.pic_vehicle_front,
      pic_vehicle_rear: pic_vehicle_rear ?? this.pic_vehicle_rear,
      pic_vehicle_left: pic_vehicle_left ?? this.pic_vehicle_left,
      pic_vehicle_right: pic_vehicle_right ?? this.pic_vehicle_right,
      pic_meter_reading: pic_meter_reading ?? this.pic_meter_reading,
      pic_engine_number: pic_engine_number ?? this.pic_engine_number,
      pic_chassis_number: pic_chassis_number ?? this.pic_chassis_number,
      insurance_valuation: insurance_valuation ?? this.insurance_valuation,
      lease_valuation: lease_valuation ?? this.lease_valuation,
      is_completed: is_completed ?? this.is_completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_registered': is_registered,
      'chassis_number': chassis_number,
      'engine_number': engine_number,
      'engine_capacity': engine_capacity,
      'number_plate': number_plate,
      'registered_year': registered_year,
      'make': make,
      'model': model,
      'manufactured_year': manufactured_year,
      'meter_reading': meter_reading,
      'seating_capacity': seating_capacity,
      'pic_registration_certificate': pic_registration_certificate,
      'pic_lessee_and_vehicle': pic_lessee_and_vehicle,
      'pic_vehicle_front': pic_vehicle_front,
      'pic_vehicle_rear': pic_vehicle_rear,
      'pic_vehicle_left': pic_vehicle_left,
      'pic_vehicle_right': pic_vehicle_right,
      'pic_meter_reading': pic_meter_reading,
      'pic_engine_number': pic_engine_number,
      'pic_chassis_number': pic_chassis_number,
      'insurance_valuation': insurance_valuation,
      'lease_valuation': lease_valuation,
      'is_completed': is_completed,
    };
  }

  @override
  String toString() {
    return 'VehicleRecord{is_registered: $is_registered, chassis_number: $chassis_number, engine_number: $engine_number, engine_capacity: $engine_capacity, number_plate: $number_plate, registered_year: $registered_year, make: $make, model: $model, manufactured_year: $manufactured_year, meter_reading: $meter_reading, seating_capacity: $seating_capacity, pic_registration_certificate: $pic_registration_certificate, pic_lessee_and_vehicle: $pic_lessee_and_vehicle, pic_vehicle_front: $pic_vehicle_front, pic_vehicle_rear: $pic_vehicle_rear, pic_vehicle_left: $pic_vehicle_left, pic_vehicle_right: $pic_vehicle_right, pic_meter_reading: $pic_meter_reading, pic_engine_number: $pic_engine_number, pic_chassis_number: $pic_chassis_number, insurance_valuation: $insurance_valuation, lease_valuation: $lease_valuation, is_completed: $is_completed}';
  }

  factory VehicleRecord.fromJson(Map<String, dynamic> json) {
    return VehicleRecord(
      is_registered: json['is_registered'],
      chassis_number: json['chassis_number'],
      engine_number: json['engine_number'],
      engine_capacity: json['engine_capacity'],
      number_plate: json['number_plate'],
      registered_year: json['registered_year'],
      make: json['make'],
      model: json['model'],
      manufactured_year: json['manufactured_year'],
      meter_reading: json['meter_reading'],
      seating_capacity: json['seating_capacity'],
      pic_registration_certificate: json['pic_registration_certificate'],
      pic_lessee_and_vehicle: json['pic_lessee_and_vehicle'],
      pic_vehicle_front: json['pic_vehicle_front'],
      pic_vehicle_rear: json['pic_vehicle_rear'],
      pic_vehicle_left: json['pic_vehicle_left'],
      pic_vehicle_right: json['pic_vehicle_right'],
      pic_meter_reading: json['pic_meter_reading'],
      pic_engine_number: json['pic_engine_number'],
      pic_chassis_number: json['pic_chassis_number'],
      insurance_valuation: json['insurance_valuation'],
      lease_valuation: json['lease_valuation'],
      is_completed: json['is_completed'] == 1 ? true : false,
    );
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:dearo_app/models/data/vehicle_record.dart';

class ResponseVehicleEssentials{
  final bool error;
  final String message;
  final VehicleRecord? vehicle_record;

  ResponseVehicleEssentials({
    required this.error,
    required this.message,
    required this.vehicle_record
  });

  factory ResponseVehicleEssentials.fromJson(Map<String, dynamic> json){
    late ResponseVehicleEssentials responseVehicleEssentials;

    try{
      responseVehicleEssentials = ResponseVehicleEssentials(
          error: json['error'],
          message: json['message'],
          vehicle_record: VehicleRecord.fromJson(json['vehicle_record']),
      );

      return responseVehicleEssentials;
    }catch(e){
      return ResponseVehicleEssentials(
        error: true,
        message: e.toString(),
        vehicle_record: null
      );
    }
  }
}
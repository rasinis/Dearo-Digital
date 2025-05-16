// ignore_for_file: non_constant_identifier_names

import '../../models/data/vehicle_record.dart';

class ResponseVehicleImage{
  final bool error;
  final String message;
  final String? image_type;
  final VehicleRecord? vehicle_record;  

  ResponseVehicleImage({
    required this.error,
    required this.message,
    required this.image_type,
    required this.vehicle_record
  });

  factory ResponseVehicleImage.fromJson(Map<String, dynamic> json){
    late ResponseVehicleImage responseVehicleImage;

    try{
      responseVehicleImage = ResponseVehicleImage(
        error: json['error'],
        message: json['message'],
        image_type: json['image_type'],
        vehicle_record: VehicleRecord.fromJson(json['vehicle_record']),
      );

      return responseVehicleImage;
    }catch(e){
      return ResponseVehicleImage(
          error: true,
          message: e.toString(),
          image_type: null,
          vehicle_record: null
      );
    }
  }
}
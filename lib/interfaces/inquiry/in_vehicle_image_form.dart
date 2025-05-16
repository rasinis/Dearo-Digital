// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dearo_app/models/data/vehicle_record.dart';
import 'package:dearo_app/api/api_manager.dart';
//import 'package:dearo_app/api/responses/response_vehicle_image.dart';

void main() {
  runApp(
    const MaterialApp(
      home: VehiclePhotoProofInScreen(
        bearerToken: 'sampleBearerToken', // Replace with actual token
        inquiryId: 3, // Replace with actual inquiry ID
        inquiryType: 'FD', // Replace with actual inquiry type
      ),
    ),
  );
}

class VehiclePhotoProofInScreen extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;
  final String inquiryType;

  const VehiclePhotoProofInScreen({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
    required this.inquiryType,
  }) : super(key: key);

  @override
  _VehiclePhotoProofInScreenState createState() =>
      _VehiclePhotoProofInScreenState();
}

class _VehiclePhotoProofInScreenState extends State<VehiclePhotoProofInScreen> {
  final ApiManager _apiManager = ApiManager(); // Instance of ApiManager
  VehicleRecord vehicleRecord = VehicleRecord(
    is_registered: true,
    chassis_number: '',
    engine_number: '',
    engine_capacity: '',
    make: '',
    model: '',
    manufactured_year: '',
  );

  Future<void> _pickFile(String photoType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          switch (photoType) {
            case 'vehicle_front':
              vehicleRecord.pic_vehicle_front = filePath;
              break;
            case 'vehicle_left':
              vehicleRecord.pic_vehicle_left = filePath;
              break;
            case 'vehicle_right':
              vehicleRecord.pic_vehicle_right = filePath;
              break;
            case 'vehicle_rear':
              vehicleRecord.pic_vehicle_rear = filePath;
              break;
            case 'chassis_number':
              vehicleRecord.pic_chassis_number = filePath;
              break;
            case 'engine_number':
              vehicleRecord.pic_engine_number = filePath;
              break;
            case 'meter_reading':
              vehicleRecord.pic_meter_reading = filePath;
              break;
            case 'lessee_and_vehicle':
              vehicleRecord.pic_lessee_and_vehicle = filePath;
              break;
            case 'registration_certificate':
              vehicleRecord.pic_registration_certificate = filePath;
              break;
          }
        }
      });
    }
  }

  Future<void> _submitVehicleImages() async {
    try {
      final response = await _apiManager.uploadVehicleImage(
        widget.bearerToken, // Use the bearerToken from the widget
        File(vehicleRecord.pic_vehicle_front!), // Example file
        'vehicle_front.jpg', // Example file name
        'vehicle_front', // Image type
        widget.inquiryId, // Use the inquiryId from the widget
      );

      if (!response.error) {
        print('Message: ${response.message}');
        print('Image Type: ${response.image_type}');
        print('Vehicle Record: ${response.vehicle_record}');
      } else {
        print('Error: ${response.message}');
      }
    } catch (e) {
      print('Error uploading vehicle images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Photo Proof'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.indigo.shade900,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vehicle Exterior Photos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              buildPhotoRow(
                'Vehicle Front',
                vehicleRecord.pic_vehicle_front,
                'vehicle_front',
              ),
              buildPhotoRow(
                'Vehicle Left',
                vehicleRecord.pic_vehicle_left,
                'vehicle_left',
              ),
              buildPhotoRow(
                'Vehicle Right',
                vehicleRecord.pic_vehicle_right,
                'vehicle_right',
              ),
              buildPhotoRow(
                'Vehicle Back',
                vehicleRecord.pic_vehicle_rear,
                'vehicle_rear',
              ),

              const SizedBox(height: 16),
              const Text(
                'Vehicle Detail Proof',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              buildPhotoRow(
                'Chassis Number',
                vehicleRecord.pic_chassis_number,
                'chassis_number',
              ),
              buildPhotoRow(
                'Engine Number',
                vehicleRecord.pic_engine_number,
                'engine_number',
              ),
              buildPhotoRow(
                'Meter Reading',
                vehicleRecord.pic_meter_reading,
                'meter_reading',
              ),
              buildPhotoRow(
                'Lessee and Vehicle',
                vehicleRecord.pic_lessee_and_vehicle,
                'lessee_and_vehicle',
              ),
              buildPhotoRow(
                'Registration Certificate',
                vehicleRecord.pic_registration_certificate,
                'registration_certificate',
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitVehicleImages,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade900,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPhotoRow(String title, String? imagePath, String photoType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          IconButton(
            onPressed: () => _pickFile(photoType),
            icon: Icon(
              imagePath != null
                  ? Icons.check_circle
                  : Icons.add_photo_alternate,
              color: imagePath != null ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dearo_app/models/inquiry_manager.dart';
import 'package:dearo_app/models/data/vehicle_record.dart';
import 'package:dearo_app/api/api_manager.dart';
import 'package:dearo_app/models/data/inquiry_record.dart';

class VehiclePhotoProofScreen extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;
  final InquiryRecord? inquiryRecord;
  final String inquiryType;

  const VehiclePhotoProofScreen({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
    this.inquiryRecord,
    required this.inquiryType,
  }) : super(key: key);

  @override
  _VehiclePhotoProofScreenState createState() => _VehiclePhotoProofScreenState();
}

class _VehiclePhotoProofScreenState extends State<VehiclePhotoProofScreen> {
  final ApiManager _apiManager = ApiManager();
  final Map<String, File?> _fileQueue = {
    'VEHICLE-LEFT': null,
    'VEHICLE-RIGHT': null,
    'VEHICLE-FRONT': null,
    'VEHICLE-REAR': null,
    'METER-READING': null,
    'LESSEE-AND-VEHICLE': null,
    'CHASSIS-NUMBER': null,
    'ENGINE-NUMBER': null,
    'REGISTRATION-CERTIFICATE': null,
  };

  final Map<String, String?> _fileNameQueue = {
    'VEHICLE-LEFT': null,
    'VEHICLE-RIGHT': null,
    'VEHICLE-FRONT': null,
    'VEHICLE-REAR': null,
    'METER-READING': null,
    'LESSEE-AND-VEHICLE': null,
    'CHASSIS-NUMBER': null,
    'ENGINE-NUMBER': null,
    'REGISTRATION-CERTIFICATE': null,
  };

  late VehicleRecord vehicleRecord;

  @override
  void initState() {
    super.initState();
    
    // Initialize vehicleRecord with proper null checks
    vehicleRecord = widget.inquiryRecord?.inquiry_info?.vehicle_record ?? 
        VehicleRecord(
          is_registered: true,
          chassis_number: '',
          engine_number: '',
          engine_capacity: '',
          make: '',
          model: '',
          manufactured_year: '',
        );
    
    debugPrint('VehicleRecord initialized: ${vehicleRecord.toString()}');
  }

  Future<void> _pickFile({required String imageType}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        File file = File(result.files.single.path!);
        String fileName = result.files.single.name;

        setState(() {
          _fileQueue[imageType] = file;
          _fileNameQueue[imageType] = fileName;
        });

        _showSuccess('$imageType image selected');
      }
    } catch (e) {
      _showError('Error picking file: ${e.toString()}');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
    ),
    );
  }

  Future<void> _submitVehicleImages() async {
    // Check if at least one image is selected
    if (_fileQueue.values.every((file) => file == null)) {
      _showError('Please select at least one photo before submitting.');
      return;
    }

    try {
      bool allUploadsSuccessful = true;
      
      // Upload each selected file
      for (var entry in _fileQueue.entries) {
        if (entry.value != null) {
          final response = await _apiManager.uploadVehicleImage(
            widget.bearerToken,
            entry.value!,
            _fileNameQueue[entry.key] ?? 'image.jpg',
            entry.key,
            widget.inquiryId,
          );

          if (response.error) {
            allUploadsSuccessful = false;
            _showError('Failed to upload ${entry.key}: ${response.message}');
          } else {
            if (response.vehicle_record != null) {
              setState(() {
                vehicleRecord = response.vehicle_record!;
              });
            }
            _showSuccess('${entry.key} uploaded successfully');
          }
        }
      }

      if (allUploadsSuccessful) {
        // Navigate to next screen only if all uploads were successful
        _navigateToNextScreen();
      }
    } catch (e) {
      _showError('Error uploading images: ${e.toString()}');
    }
  }

  void _navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InquiryManager.getNextLeasingScreen(
          bearerToken: widget.bearerToken,
          currentState: 'VEHICLE_IMAGES_ADDED',
          inquiryId: widget.inquiryId,
        ),
      ),
    );
  }

  Widget _buildImageUploadButton(String imageType, String buttonText) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _pickFile(imageType: imageType),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 0),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder( // Use shape instead of border
            borderRadius: BorderRadius.circular(10),),
            
  
            //borderRadius: BorderRadius.circular(10),
            //borderSide: BorderSide.none,),
            backgroundColor: _fileQueue[imageType] != null 
                ? Colors.blue[200] 
                : Color(0xFFDEDFF2),
            
          ),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.black),
        ),
        ),
        SizedBox(height: 4),
        if (_fileNameQueue[imageType] != null)
          Text(
            'Selected: ${_fileNameQueue[imageType]}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Photo Proof'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Vehicle Exterior Photos Section
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Exterior Photos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildImageUploadButton('VEHICLE-FRONT', 'Front View'),
                      SizedBox(height: 12),
                      _buildImageUploadButton('VEHICLE-LEFT', 'Left Side View'),
                      SizedBox(height: 12),
                      _buildImageUploadButton('VEHICLE-RIGHT', 'Right Side View'),
                      SizedBox(height: 12),
                      _buildImageUploadButton('VEHICLE-REAR', 'Rear View'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Vehicle Details Section
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildImageUploadButton('CHASSIS-NUMBER', 'Chassis Number'),
                      SizedBox(height: 12),
                      _buildImageUploadButton('ENGINE-NUMBER', 'Engine Number'),
                      SizedBox(height: 12),
                      _buildImageUploadButton('METER-READING', 'Meter Reading'),
                      SizedBox(height: 12),
                      _buildImageUploadButton('LESSEE-AND-VEHICLE', 'Lessee with Vehicle'),
                      SizedBox(height: 12),
                      _buildImageUploadButton('REGISTRATION-CERTIFICATE', 'Registration Certificate'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submitVehicleImages,
                style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder( // Use shape instead of border
            borderRadius: BorderRadius.circular(10),
          ),
                  backgroundColor: Colors.indigo.shade900,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Submit All Photos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
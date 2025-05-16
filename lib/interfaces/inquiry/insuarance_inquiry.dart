// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:dearo_app/interfaces/inquiry/upload_vehicle_proof.dart';
import 'package:flutter/material.dart';
import 'package:dearo_app/models/data/vehicle_record.dart';
import 'package:dearo_app/models/data/inquiry_record.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InsuaranceFormScreen(
        bearerToken: 'sampleToken',
        inquiryId: 3,
        inquiryType: 'INSURANCE',
      ),
    );
  }
}

class InsuaranceFormScreen extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;
  final String inquiryType;
  final InquiryRecord? inquiryRecord;

  const InsuaranceFormScreen({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
    required this.inquiryType,
    this.inquiryRecord,
  }) : super(key: key);

  @override
  _InsuaranceFormScreenState createState() => _InsuaranceFormScreenState();
}

class _InsuaranceFormScreenState extends State<InsuaranceFormScreen> {
  final TextEditingController registeredNumberController = TextEditingController();
  final TextEditingController registeredYearController = TextEditingController();
  final TextEditingController chassisNumberController = TextEditingController();
  final TextEditingController engineNumberController = TextEditingController();
  final TextEditingController engineCapacityController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController manufacturedYearController = TextEditingController();
  final TextEditingController meterReadingController = TextEditingController();
  final TextEditingController seatingCapacityController = TextEditingController();

  bool isPassed = false;

  void saveVehicleData() {
    if (registeredNumberController.text.isNotEmpty &&
        registeredYearController.text.isNotEmpty &&
        chassisNumberController.text.isNotEmpty &&
        engineNumberController.text.isNotEmpty &&
        engineCapacityController.text.isNotEmpty &&
        makeController.text.isNotEmpty &&
        modelController.text.isNotEmpty &&
        manufacturedYearController.text.isNotEmpty &&
        meterReadingController.text.isNotEmpty &&
        seatingCapacityController.text.isNotEmpty) {
      isPassed = true;

      VehicleRecord vehicleRecord = VehicleRecord(
        is_registered: true,
        chassis_number: chassisNumberController.text,
        engine_number: engineNumberController.text,
        engine_capacity: engineCapacityController.text,
        registered_year: registeredYearController.text,
        make: makeController.text,
        model: modelController.text,
        manufactured_year: manufacturedYearController.text,
        meter_reading: int.tryParse(meterReadingController.text),
        seating_capacity: int.tryParse(seatingCapacityController.text),
        is_completed: true,
      );

      print('Bearer Token: ${widget.bearerToken}');
      print('Inquiry ID: ${widget.inquiryId}');
      print('Inquiry Type: ${widget.inquiryType}');
      print('Inquiry Record: ${widget.inquiryRecord}');
      print(vehicleRecord);

      if (isPassed) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehiclePhotoProofScreen(
              bearerToken: widget.bearerToken,
              inquiryId: widget.inquiryId,
              inquiryType: widget.inquiryType,
              inquiryRecord: widget.inquiryRecord,
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LEASE',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo.shade900,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Registered Number', registeredNumberController),
              buildTextField('Registered Year', registeredYearController, isNumeric: true),
              buildTextField('Chassis Number', chassisNumberController),
              buildTextField('Engine Number', engineNumberController),
              buildTextField('Engine Capacity', engineCapacityController),
              buildTextField('Vehicle Make', makeController),
              buildTextField('Vehicle Model', modelController),
              buildTextField('Manufactured Year', manufacturedYearController, isNumeric: true),
              buildTextField('Meter Reading', meterReadingController, isNumeric: true),
              buildTextField('Seating Capacity', seatingCapacityController, isNumeric: true),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: saveVehicleData,
                    child: const Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  Widget buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFDEDFF2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
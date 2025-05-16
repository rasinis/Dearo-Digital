// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:dearo_app/models/data/vehicle_record.dart';
import 'package:dearo_app/models/inquiry_manager.dart';
import 'package:dearo_app/api/responses/response_vehicle_essentials.dart';
import 'package:dearo_app/api/responses/response_inquiry_step.dart';
import 'package:dearo_app/api/api_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LeaseFormScreen(
        bearerToken: 'sampleToken',
        inquiryId: 1,
        inquiryType: 'LEASE',
      ),
    );
  }
}

class LeaseFormScreen extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;
  final String inquiryType;

  const LeaseFormScreen({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
    required this.inquiryType,
  }) : super(key: key);

  @override
  _LeaseFormScreenState createState() => _LeaseFormScreenState();
}

class _LeaseFormScreenState extends State<LeaseFormScreen> {
  final TextEditingController registeredNumberController =
      TextEditingController();
  final TextEditingController registeredYearController =
      TextEditingController();
  final TextEditingController chassisNumberController = TextEditingController();
  final TextEditingController engineNumberController = TextEditingController();
  final TextEditingController engineCapacityController =
      TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController manufacturedYearController =
      TextEditingController();
  final TextEditingController meterReadingController = TextEditingController();
  final TextEditingController seatingCapacityController =
      TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  final ApiManager apiManager = ApiManager(); // Instance of ApiManager

  Future<void> saveVehicleData() async {
    // Check if all required fields are filled
    if (registeredNumberController.text.isEmpty ||
        registeredYearController.text.isEmpty ||
        chassisNumberController.text.isEmpty ||
        engineNumberController.text.isEmpty ||
        engineCapacityController.text.isEmpty ||
        makeController.text.isEmpty ||
        modelController.text.isEmpty ||
        manufacturedYearController.text.isEmpty ||
        meterReadingController.text.isEmpty ||
        seatingCapacityController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill all required fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Create vehicle record
      VehicleRecord vehicleRecord = VehicleRecord(
        is_registered: true,
        number_plate: registeredNumberController.text,
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

      // Call API to save vehicle essentials
      ResponseVehicleEssentials vehicleResponse = await apiManager
          .updateVehicleEssentialDetails(
            widget.bearerToken,
            vehicleRecord,
            widget.inquiryId,
          );

      if (!vehicleResponse.error && vehicleResponse.vehicle_record != null) {
        // Call API to update inquiry step
        ResponseInquiryStep stepResponse = await apiManager.updateInquiryStep(
          widget.bearerToken,
          widget.inquiryId,
          'VEHICLE_ESSENTIALS_ADDED',
        );

        if (!stepResponse.error && stepResponse.is_passed) {
          // Navigate to next screen if both operations succeed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => InquiryManager.getNextLeasingScreen(
                    bearerToken: widget.bearerToken,
                    currentState: stepResponse.inquiry_step,
                    inquiryId: widget.inquiryId,
                  ),
            ),
          );
        } else {
          setState(() {
            errorMessage = stepResponse.message;
          });
        }
      } else {
        setState(() {
          errorMessage = vehicleResponse.message;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to save vehicle details: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LEASE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo.shade900,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              buildTextField('Registered Number', registeredNumberController),
              buildTextField(
                'Registered Year',
                registeredYearController,
                isNumeric: true,
              ),
              buildTextField('Chassis Number', chassisNumberController),
              buildTextField('Engine Number', engineNumberController),
              buildTextField('Engine Capacity', engineCapacityController),
              buildTextField('Vehicle Make', makeController),
              buildTextField('Vehicle Model', modelController),
              buildTextField(
                'Manufactured Year',
                manufacturedYearController,
                isNumeric: true,
              ),
              buildTextField(
                'Meter Reading',
                meterReadingController,
                isNumeric: true,
              ),
              buildTextField(
                'Seating Capacity',
                seatingCapacityController,
                isNumeric: true,
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : saveVehicleData,
                    child:
                        isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'SAVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
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

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
  }) {
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

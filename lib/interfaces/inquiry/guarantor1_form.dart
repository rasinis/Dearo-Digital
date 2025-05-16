// ignore_for_file: avoid_print, library_private_types_in_public_api, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dearo_app/models/data/district.dart';
import 'package:dearo_app/models/district_manager.dart';
import 'package:dearo_app/models/data/guarantor_profile.dart';
import 'package:dearo_app/models/inquiry_manager.dart';
import 'package:dearo_app/api/responses/response_guarantor_profile.dart'; // Import ResponseGuarantorProfile
import 'package:dearo_app/api/responses/response_inquiry_step.dart'; // Import ResponseInquiryStep
import 'package:dearo_app/api/api_manager.dart'; // Import ApiManager

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Guarantor1Form(
        bearerToken: 'sampleBearerToken',
        inquiryId: 1,
        inquiryType: 'LEASE',
        isFirst: true,
      ),
    );
  }
}

class Guarantor1Form extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;
  final String inquiryType;
  final bool isFirst;

  const Guarantor1Form({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
    required this.inquiryType,
    required this.isFirst,
  }) : super(key: key);

  @override
  _Guarantor1FormState createState() => _Guarantor1FormState();
}

class _Guarantor1FormState extends State<Guarantor1Form> {
  final _formKey = GlobalKey<FormState>();
  final ApiManager _apiManager = ApiManager();
  int? districtId;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController nicController = TextEditingController();

  void _saveGuarantorDetails() async {
    GuarantorProfile guarantorProfile = GuarantorProfile(
      customer_id: 1, // Replace with actual data
      inquiry_id: widget.inquiryId,
      lease_inquiry_id: widget.inquiryId,
      is_first: widget.isFirst,
      first_name: firstNameController.text,
      last_name: lastNameController.text,
      nic: nicController.text,
      occupation: occupationController.text,
      contact_number: contactNumberController.text,
      address: addressController.text,
      district_id: districtId ?? 0,
    );

    print(guarantorProfile.toString());

    try {
      // Save Guarantor Details
      final guarantorResponse = await _apiManager.updateGuarantorDetails(
        widget.bearerToken,
        guarantorProfile,
        widget.isFirst ? 1 : 2, // Guarantor index (1 for first, 2 for second)
        widget.inquiryId,
      );

      if (guarantorResponse.error) {
        _showError(guarantorResponse.message);
        return;
      } else {
        print("Guarantor Profile Saved: ${guarantorResponse.guarantor_profile}");
      }

      // Update Inquiry Step
      final inquiryStepResponse = await _apiManager.updateInquiryStep(
  widget.bearerToken,
  widget.inquiryId,
  "GUARANTOR1_DETAILS_ADDED",
);

if (inquiryStepResponse.error) {
  _showError(inquiryStepResponse.message);
} else {
  print("Inquiry Step Updated: ${inquiryStepResponse.inquiry_step}");

  // Navigate to the next screen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => InquiryManager.getNextLeasingScreen(
        bearerToken: widget.bearerToken,
        currentState: inquiryStepResponse.inquiry_step,
        inquiryId: inquiryStepResponse.inquiry_id,
      ),
    ),
  );
}
    } catch (e) {
      _showError("An error occurred: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Guarantor Details"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Guarantor",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                buildTextField("First Name", firstNameController),
                buildTextField("Last Name", lastNameController),
                buildTextField("Contact Number", contactNumberController),
                const Text(
                  'District',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: DropdownMenu(
                      hintText: 'Select District',
                      width: double.maxFinite,
                      dropdownMenuEntries: DistrictManager.getDistricts()
                          .entries
                          .map((entry) {
                        return DropdownMenuEntry(
                          value: District(id: entry.key, districtName: entry.value),
                          label: entry.value,
                        );
                      }).toList(),
                        onSelected: (districtSelected) {
                        print('${districtSelected!.districtName} is selected');
                        setState(() {
                          districtId = districtSelected.id;
                        });
                      },
                      textAlign: TextAlign.start,
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                buildTextField("Address", addressController),
                buildTextField("Occupation", occupationController),
                buildTextField("NIC", nicController),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveGuarantorDetails,
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
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFDEDFF2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
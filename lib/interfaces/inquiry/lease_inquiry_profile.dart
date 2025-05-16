// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_field, avoid_print, unnecessary_null_comparison, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:dearo_app/models/data/customer_profile.dart';
import 'package:dearo_app/models/data/district.dart';
import 'package:dearo_app/models/district_manager.dart';
import 'package:dearo_app/models/shared_preference_manager.dart';
import 'package:dearo_app/api/responses/response_inquiry_initiated.dart';
import 'package:dearo_app/api/responses/response_profile_nic.dart';
import 'package:dearo_app/api/responses/response_profile_update.dart';
import 'package:dearo_app/api/api_manager.dart';
import 'package:dearo_app/models/inquiry_manager.dart';

class LeaseInquiryProForm extends StatefulWidget {
  final bool isInquiryPending;
  final String inquiryType;
  final String bearerToken;

  const LeaseInquiryProForm({
    Key? key,
    required this.isInquiryPending,
    required this.inquiryType,
    required this.bearerToken,
  }) : super(key: key);

  @override
  _LeaseInquiryProFormState createState() => _LeaseInquiryProFormState();
}

class _LeaseInquiryProFormState extends State<LeaseInquiryProForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  late File _fileNicFront;
  String _fileNameNicFront = '';
  late File _fileNicBack;
  String _fileNameNicBack = '';

  bool _isSubmitting = false;
  bool _isUploadingNic = false;

  late int inquiryId;
  String? selectedDistrict;
  CustomerProfile? _customerProfile;
  final ApiManager _apiManager = ApiManager();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadCustomerProfile();
  }

  Future<void> _loadCustomerProfile() async {
    try {
      CustomerProfile? customerProfile = await SharedPreferenceManager.getCustomerProfile();
      if (customerProfile != null) {
        setState(() {
          _customerProfile = customerProfile;
        });
        _prefillFormFields();
      }
    } catch (e) {
      _showFlashMessage(context, "Failed to load profile: ${e.toString()}");
    }
  }

  void _prefillFormFields() {
    if (_customerProfile != null) {
      setState(() {
        firstNameController.text = _customerProfile!.first_name;
        lastNameController.text = _customerProfile!.last_name;
        contactNumberController.text = _customerProfile!.mobile_number;
        if (_customerProfile!.nic != null) nicController.text = _customerProfile!.nic!;
        if (_customerProfile!.address != null) addressController.text = _customerProfile!.address!;
        if (_customerProfile!.dob != null) {
          _dateController.text = DateFormat('yyyy-MM-dd').format(_customerProfile!.dob!);
        }
        if (_customerProfile!.district != null) {
          selectedDistrict = DistrictManager.getDistrict(_customerProfile!.district!)?.districtName;
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = _customerProfile?.dob ?? DateTime(1990);
    DateTime firstDate = DateTime(1940);
    DateTime lastDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> pickFile(bool isFront) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          if (isFront) {
            _fileNicFront = File(result.files.single.path!);
            _fileNameNicFront = result.files.single.name;
          } else {
            _fileNicBack = File(result.files.single.path!);
            _fileNameNicBack = result.files.single.name;
          }
        });
      }
    } catch (e) {
      _showFlashMessage(context, "File selection failed: ${e.toString()}");
    }
  }

  void _showFlashMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _uploadNicFiles(String token) async {
    try {
      if (_fileNameNicFront.isNotEmpty) {
        setState(() => _isUploadingNic = true);
        ResponseProfileNic responseNicFront = await _apiManager.uploadCustomerNic(
          token,
          _fileNicFront,
          _fileNameNicFront,
          'front',
        );

        if (!responseNicFront.error) {
          _showFlashMessage(context, "NIC front uploaded successfully");
        } else {
          _showFlashMessage(context, "NIC front upload failed: ${responseNicFront.message}");
        }
      }

      if (_fileNameNicBack.isNotEmpty) {
        setState(() => _isUploadingNic = true);
        ResponseProfileNic responseNicBack = await _apiManager.uploadCustomerNic(
          token,
          _fileNicBack,
          _fileNameNicBack,
          'back',
        );

        if (!responseNicBack.error) {
          _showFlashMessage(context, "NIC back uploaded successfully");
        } else {
          _showFlashMessage(context, "NIC back upload failed: ${responseNicBack.message}");
        }
      }
    } catch (e) {
      _showFlashMessage(context, "NIC upload error: ${e.toString()}");
    } finally {
      setState(() => _isUploadingNic = false);
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && !_isSubmitting) {
      setState(() => _isSubmitting = true);

      try {
        final String token = widget.bearerToken;

        if (_fileNameNicFront.isEmpty || _fileNameNicBack.isEmpty) {
          _showFlashMessage(context, "Please upload both NIC front and back images.");
          return;
        }

        CustomerProfile profile = CustomerProfile(
          first_name: firstNameController.text,
          last_name: lastNameController.text,
          mobile_number: contactNumberController.text,
          dob: _dateController.text.isNotEmpty
              ? DateTime.parse(_dateController.text)
              : null,
          address: addressController.text,
          district: selectedDistrict != null
               ? districts.firstWhere((d) => d.districtName == selectedDistrict).id
              : null,
          nic: nicController.text,
          is_completed: true,
        );

        await SharedPreferenceManager.updateCustomerProfile(profile);

        ResponseProfileUpdate responseProfileUpdate =
            await _apiManager.updateCustomerProfile(token, profile);

        if (!responseProfileUpdate.error) {
          await _uploadNicFiles(token);

          final ResponseInquiryInitiated response =
              await _apiManager.initiateInquiry(token, widget.inquiryType);

          if (!response.error) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => InquiryManager.getNextLeasingScreen(
                  bearerToken: token,
                  currentState: 'PROFILE_COMPLETED',
                  inquiryId: response.inquiry_id!,
                ),
              ),
              (Route<dynamic> route) => false,
            );
          } else {
            _showFlashMessage(context, response.message);
          }
        } else {
          _showFlashMessage(context, responseProfileUpdate.message);
        }
      } catch (e) {
        _showFlashMessage(context, "Error: ${e.toString()}");
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }
  
   List<District> get districts => DistrictManager.getDistricts()
      .entries
      .map((e) => District(id: e.key, districtName: e.value))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Profile"),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField("First Name", firstNameController),
                buildTextField("Last Name", lastNameController),
                buildTextField("Contact Number", contactNumberController),
                buildDistrictDropdown(),
                buildTextField("Address", addressController),
                buildTextField("NIC", nicController),
                buildDateField(),
                buildNicUploadButton(true),
                const SizedBox(height: 10),
                buildNicUploadButton(false),
                const SizedBox(height: 20),
                buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Widget buildDistrictDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "District",
          filled: true,
          fillColor: const Color(0xFFDEDFF2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        value: selectedDistrict,
        items: districts.map((District district) {
          return DropdownMenuItem<String>(
            value: district.districtName,
            child: Text(district.districtName),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedDistrict = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a district';
          }
          return null;
        },
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
    
        
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          labelText: "Date of Birth",
          suffixIcon: const Icon(Icons.calendar_month),
          filled: true,
          fillColor: const Color(0xFFDEDFF2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
         
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your date of birth';
          }
          return null;
        },
      ),
    );
  }

  Widget buildNicUploadButton(bool isFront) {
    final hasFile = isFront ? _fileNameNicFront.isNotEmpty : _fileNameNicBack.isNotEmpty;
    final fileName = isFront ? _fileNameNicFront : _fileNameNicBack;

    return ElevatedButton(
      onPressed: () => pickFile(isFront),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFDEDFF2),
        minimumSize: Size(double.infinity, 0),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide.none,
        ),
      ),
      child: Text(hasFile ? fileName : "Upload ${isFront ? 'Front' : 'Back'} NIC"),
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      
       style: ElevatedButton.styleFrom(
        
          backgroundColor: Colors.indigo.shade900,
          minimumSize: Size(double.infinity, 0),

          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),

          ),
        ),
      child: const Text("Submit",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20),),
    );
  }
} 
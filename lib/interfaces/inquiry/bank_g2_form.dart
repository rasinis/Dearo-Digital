// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously, unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
//import 'package:google_fonts/google_fonts.dart';

// API Responses
import 'package:dearo_app/api/responses/response_bank_statement.dart';
import 'package:dearo_app/api/responses/response_billing_proof.dart';
import 'package:dearo_app/api/responses/response_inquiry_step.dart';

// API Manager
import 'package:dearo_app/api/api_manager.dart';
import 'package:dearo_app/models/inquiry_manager.dart';

class BankG2Form extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;
  final String inquiryType;
  final bool isCustomer;

  const BankG2Form({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
    required this.inquiryType,
    required this.isCustomer, required bool isFirst,
  }) : super(key: key);

  @override
  _BankG2FormState createState() => _BankG2FormState();
}

class _BankG2FormState extends State<BankG2Form> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _billTitleController = TextEditingController();
  final ApiManager _apiManager = ApiManager();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  File? _statementFile;
  File? _billingProofFile;
  String? _selectedBillType;
  String? _statementFileName;
  String? _billingProofFileName;
  bool _isSubmitting = false;

  final Map<String, String> _billTypes = {
    'WATER_BILL': 'Water Bill',
    'ELECTRICITY_BILL': 'Electricity Bill',
    'OTHER_BILL': 'Other Bill'
  };

  // Validation messages 
  String? _validateDate(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select $fieldName';
    }
    return null;
  }

  String? _validateBillType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a bill type';
    }
    return null;
  }

  String? _validateBillName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a bill name';
    }
    if (value.length < 3) {
      return 'Bill name must be at least 3 characters';
    }
    return null;
  }

  String? _validateFile(File? file, String fileName, String fieldName) {
    if (file == null || fileName.isEmpty) {
      return 'Please upload $fieldName';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller, String fieldName) async {
    DateTime initialDate = DateTime(DateTime.now().year);
    DateTime firstDate = DateTime(DateTime.now().year-1);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
        // Clear any previous validation error
        _formKey.currentState?.validate();
      });
    }
  }

  Future<void> _pickFile({required String fileType}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      );

      if (result != null && result.files.isNotEmpty) {
        File file = File(result.files.single.path!);
        String fileName = result.files.single.name;
        
        // Validate file size (max 5MB)
        if (file.lengthSync() > 5 * 1024 * 1024) {
          _showError("File size should be less than 5MB");
          return;
        }

        setState(() {
          if (fileType == "BANK_STATEMENT") {
            _statementFile = file;
            _statementFileName = fileName;
          } else if (fileType == "BILLING_PROOF") {
            _billingProofFile = file;
            _billingProofFileName = fileName;
          }
        });

        // Validate the form after file selection
        _formKey.currentState?.validate();
        _showFlashMessage('${fileType.replaceAll('_', ' ')} file selected: $fileName');
      } else {
        print("File selection canceled.");
      }
    } catch (e) {
      print("Error picking file: $e");
      _showError("Error picking file: $e");
    }
  }

  void _saveData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Upload Bank Statement
      if (_statementFile != null && _statementFileName != null) {
        final bankStatementResponse = await _apiManager.uploadBankStatement(
          widget.bearerToken,
          _statementFile!,
          _statementFileName!,
          _startDateController.text,
          _endDateController.text,
          widget.inquiryId,
        );

        if (bankStatementResponse.error) {
          _showError(bankStatementResponse.message);
          setState(() {
            _isSubmitting = false;
          });
          return;
        }
      }

      // Upload Billing Proof
      if (_billingProofFile != null && _billingProofFileName != null && _selectedBillType != null) {
        final billingProofResponse = await _apiManager.uploadCustomerBillingProof(
          widget.bearerToken,
          _billingProofFile!,
          _billingProofFileName!,
          _billTitleController.text,
          _selectedBillType!,
          widget.inquiryId,
        );

        if (billingProofResponse.error) {
          _showError(billingProofResponse.message);
          setState(() {
            _isSubmitting = false;
          });
          return;
        }
      }

      // Update Inquiry Step
      final inquiryStepResponse = await _apiManager.updateInquiryStep(
        widget.bearerToken,
        widget.inquiryId,
        "BANK_BILLING_ADDED",
      );

      setState(() {
        _isSubmitting = false;
      });

      if (inquiryStepResponse.error) {
        _showError(inquiryStepResponse.message);
      } else {
        _showFlashMessage("Information Saved Successfully");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InquiryManager.getNextLeasingScreen(
              bearerToken: widget.bearerToken,
              currentState: inquiryStepResponse.inquiry_step,
              inquiryId: inquiryStepResponse.inquiry_id,
              isCustomer: widget.isCustomer,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });
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

  void _showFlashMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bank and Billing Proof", style: TextStyle(color: Colors.indigo.shade900)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle("Bank Proofs"),
              buildDateField("Statement From Date", _startDateController, "start date"),
              const SizedBox(height: 10),
              buildDateField("Statement To Date", _endDateController, "end date"),
              const SizedBox(height: 5),
              buildFileUploadField("Bank Proof", "BANK_STATEMENT"),
              const SizedBox(height: 20),
              buildSectionTitle("Billing Proof"),
              const SizedBox(height: 10),
              buildDropdownField("Select The Bill Type"),
              const SizedBox(height: 10),
              buildTextField("Bill Name", _billTitleController),
              const SizedBox(height: 5),
              buildFileUploadField("Billing Proof", "BILLING_PROOF"),
              const SizedBox(height: 30),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade900,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'SAVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildDateField(String label, TextEditingController controller, String fieldName) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: (value) => _validateDate(value, fieldName),
      onTap: () => _selectDate(context, controller, fieldName),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_month),
        filled: true,
        fillColor: const Color(0xFFDEDFF2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildFileUploadField(String title, String fileType) {
    String? fileName;
    String? errorMessage;
    
    if (fileType == "BANK_STATEMENT") {
      fileName = _statementFileName;
      errorMessage = _validateFile(_statementFile, _statementFileName ?? '', 'bank proof');
    } else if (fileType == "BILLING_PROOF") {
      fileName = _billingProofFileName;
      errorMessage = _validateFile(_billingProofFile, _billingProofFileName ?? '', 'billing proof');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _pickFile(fileType: fileType),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text('Pick a file'),
            ),
            const SizedBox(width: 10),
            if (fileName != null)
              Expanded(
                child: Text(
                  fileName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownField(String label) {
    return DropdownButtonFormField<String>(
      validator: _validateBillType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFDEDFF2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      items: _billTypes.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedBillType = value;
          // Validate after selection
          _formKey.currentState?.validate();
        });
      },
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: _validateBillName,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFDEDFF2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
// ignore_for_file: unused_import, library_private_types_in_public_api, avoid_print, use_build_context_synchronously, unused_catch_clause

import 'package:dearo_app/interfaces/inquiry/submit_inquiry.dart';
import 'package:dearo_app/models/data/inquiry_fd.dart';
import 'package:dearo_app/models/shared_preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:dearo_app/models/inquiry_manager.dart';
import 'package:dearo_app/api/api_manager.dart';
import 'package:dearo_app/api/responses/response_fd_details.dart';
import 'package:dearo_app/api/responses/response_inquiry_step.dart';
import 'package:dearo_app/api/responses/response_submit_fd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InvestmentForm(
        bearerToken: 'sampleToken',
        currentState: 'PROFILE_COMPLETED',
        inquiryId: 0,
        inquiryType: 'FD',
        currentStte: '',
      ),
    );
  }
}

class InvestmentForm extends StatefulWidget {
  final String bearerToken;
  final String currentState;
  final int inquiryId;
  final String inquiryType;

  const InvestmentForm({
    Key? key,
    required this.bearerToken,
    required this.currentState,
    required this.inquiryId,
    required this.inquiryType,
    required String currentStte,
  }) : super(key: key);

  @override
  _InvestmentFormState createState() => _InvestmentFormState();
}

class _InvestmentFormState extends State<InvestmentForm> {
  final ApiManager _apiManager = ApiManager();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  String? selectedPeriod;
  bool _isLoading = false;
  final List<String> periods = [
    '1 Month',
    '3 Months',
    '6 months',
    '1 Year',
    '2 Years',
    '3 Years',
    '4 Years',
    '5 Years',
  ];

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _submitInvestmentDetails() async {
    if (amountController.text.isEmpty ||
        selectedPeriod == null ||
        interestController.text.isEmpty) {
      _showError('Please fill all fields.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final amount = int.parse(amountController.text);
      final interestRate = double.parse(interestController.text);

      final bearerToken = await SharedPreferenceManager.getBearerToken();
      if (bearerToken == null) {
        _showError('Bearer token not found.');
        return;
      }

      print('Attempting to update FD details...');
      final ResponseFdDetails fdResponse = await _apiManager.updateFdDetails(
        bearerToken,
        amount,
        selectedPeriod!,
        interestRate,
        widget.inquiryId,
        inquiryType: widget.inquiryType,
      ).timeout(const Duration(seconds: 30), onTimeout: () {
        throw TimeoutException('Request timed out');
      });

      if (fdResponse.error) {
        _showError(fdResponse.message);
        return;
      }

      print('FD details updated successfully. Updating inquiry step...');
      final ResponseInquiryStep inquiryStepResponse =
          await _apiManager.updateInquiryStep(
        bearerToken,
        widget.inquiryId,
        "FD_DETAILS_ADDED",
      ).timeout(const Duration(seconds: 30), onTimeout: () {
        throw TimeoutException('Request timed out');
      });

      if (inquiryStepResponse.error) {
        _showError(inquiryStepResponse.message);
        return;
      }

      _showSuccess('Investment details saved successfully.');
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InquiryManager.getNextFdScreen(
            bearerToken: bearerToken,
            currentState: inquiryStepResponse.inquiry_step,
            inquiryId: inquiryStepResponse.inquiry_id,
          ),
        ),
      );
    } on FormatException {
      _showError('Please enter valid numbers for amount and interest rate.');
    } on TimeoutException catch (e) {
      _showError('Request timed out. Please check your connection and try again.');
    } catch (e) {
      print('Error in _submitInvestmentDetails: $e');
      _showError('Something went wrong. Please try again. Details: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'INVESTMENT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Text('Amount'),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
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
                  const Text('Period'),
                  DropdownButtonFormField<String>(
                    value: selectedPeriod,
                    items: periods.map((String period) {
                      return DropdownMenuItem<String>(
                        value: period,
                        child: Text(period),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedPeriod = newValue;
                      });
                    },
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
                  const Text('Expected Interest Rate %'),
                  TextField(
                    controller: interestController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFDEDFF2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade900,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: _isLoading ? null : _submitInvestmentDetails,
                      child: _isLoading
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const ModalBarrier(
              color: Colors.black54,
              dismissible: false,
            ),
        ],
      ),
    );
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  
  @override
  String toString() => message;
}
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dearo_app/interfaces/inquiry/submit_inquiry.dart';
import '/models/data/jewellery_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoldLoanForm(
         bearerToken: 'sampleToken', // Replace with the actual token
        inquiryId: 4,
      ),
    );
  }
}

class GoldLoanForm extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;

  const GoldLoanForm({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
  }) : super(key: key);

  @override
  _GoldLoanFormState createState() => _GoldLoanFormState();
}

class _GoldLoanFormState extends State<GoldLoanForm> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  String? selectedPeriod;
  final List<String> periods = ['1 Month', '3 Months', '6 Months', '1 Year', '2 Years', '3 Years', '4 Years', '5 Years'];

  // Example jewellery types
  final List<JewelleryType> jewelleryTypes = [
    JewelleryType(id: 1, name: 'Gold Ring', count: 2),
    JewelleryType(id: 2, name: 'Gold Necklace', count: 1),
    JewelleryType(id: 3, name: 'Gold Bracelet', count: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GOLD LOAN',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            const Text('Jewellery Types'),
            Column(
              children: jewelleryTypes.map((type) => Text('${type.name} - ${type.count}')).toList(),
            ),
            const SizedBox(height: 40),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubmitInquiryScreen(
                      bearerToken: 'sampleToken',
                      inquiryId: 4,
                    )),
                  );
                },
                child: const Text(
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
    );
  }
}

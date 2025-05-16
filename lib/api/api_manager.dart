// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import '../../api/responses/response_bank_statement.dart';
import '../../api/responses/response_billing_proof.dart';
import '../../api/responses/response_fd_details.dart';
import '../../api/responses/response_guarantor_profile.dart';
import '../../api/responses/response_inquiries.dart';
import '../../api/responses/response_inquiry_initiated.dart';
import '../../api/responses/response_inquiry_step.dart';
import '../../api/responses/response_pawning_details.dart';
import '../../api/responses/response_profile_nic.dart';
import '../../api/responses/response_profile_update.dart';
import '../../api/responses/response_submit_fd.dart';
import '../../api/responses/response_submit_insurance.dart';
import '../../api/responses/response_submit_lease.dart';
import '../../api/responses/response_submit_pawning.dart';
import '../../api/responses/response_vehicle_essentials.dart';
import '../../api/responses/response_vehicle_image.dart';
import '../../models/data/customer_profile.dart';
import '../../models/data/guarantor_profile.dart';
import '../../models/session_manager.dart';
import 'package:http/http.dart' as http;
import '../../api/responses/response_user_register.dart';

import '../models/data/vehicle_record.dart';

class ApiManager {
  // final String baseUrl = 'http://192.168.8.145:8000/api/v1/';
  final String baseUrl = 'https://dearoinvestment.com/api/v1/';

  Future<ResponseUserRegister> registerUser(
    String mobile,
    String password,
    String firstName,
    String lastName,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'mobile': mobile,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseUserRegister.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseUserRegister> loginUser(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({'identifier': username, 'password': password}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseUserRegister.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseInquiries> getUserInquiries(
    String token,
    SessionManager sessionManager,
  ) async {
    final response = await http.get(
      Uri.parse('${baseUrl}inquiries'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseInquiries.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      print('Session unauthenticated while getting inquiries');
      await sessionManager.expireSession();
      throw Exception('Unauthenticated session');
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseInquiryStep> updateInquiryStep(
    String token,
    int inquiryId,
    String inquiryStep,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/validate-step'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'inquiry_id': inquiryId, 'inquiry_step': inquiryStep}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseInquiryStep.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseProfileUpdate> updateCustomerProfile(
    String token,
    CustomerProfile customerProfileUpdated,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}customer/profile/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'date_of_birth': customerProfileUpdated.dob.toString(),
        'customer_nic': customerProfileUpdated.nic,
        'customer_address': customerProfileUpdated.address,
        'customer_district': customerProfileUpdated.district,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseProfileUpdate.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  // Function to upload the file
  Future<ResponseProfileNic> uploadCustomerNic(
    String token,
    File fileNic,
    String fileName,
    String nicSide,
  ) async {
    final uri = Uri.parse('${baseUrl}customer/profile/nic');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Content-Type': 'application/json;',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'nic_file',
        fileNic.readAsBytesSync(),
        filename: fileName.split("/").last,
      ),
    );
    request.fields['nic_side'] = nicSide;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String bodyString = await response.stream.bytesToString();
        print(bodyString);
        return ResponseProfileNic.fromJson(jsonDecode(bodyString));
      } else {
        throw Exception('Something went wrong. Please try again.');
      }
    } catch (e) {
      throw Exception(
        'Something went wrong. Please try again. ${e.toString()}',
      );
    }
  }

  Future<ResponseInquiryInitiated> initiateInquiry(
    String token,
    String inquiryType,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/new-inquiry'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'inquiry_type': inquiryType}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseInquiryInitiated.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseVehicleEssentials> updateVehicleEssentialDetails(
    String token,
    VehicleRecord vehicleRecord,
    int inquiryId,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/vehicle/essentials'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'a pplication/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'inquiry_id': inquiryId,
        'vehicle_register_state':
            vehicleRecord.is_registered ? 'REGISTERED' : 'NOT-REGISTERED',
        'vehicle_registered_number': vehicleRecord.number_plate,
        'registered_year': vehicleRecord.registered_year,
        'vehicle_make': vehicleRecord.make,
        'vehicle_model': vehicleRecord.model,
        'manufactured_year': vehicleRecord.manufactured_year,
        'meter_reading': vehicleRecord.meter_reading,
        'engine_number': vehicleRecord.engine_number,
        'chassis_number': vehicleRecord.chassis_number,
        'engine_capacity': vehicleRecord.engine_capacity,
        'seating_capacity': vehicleRecord.seating_capacity,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseVehicleEssentials.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseVehicleImage> uploadVehicleImage(
    String token,
    File file,
    String fileName,
    String imageType,
    int inquiryId,
  ) async {
    final uri = Uri.parse('${baseUrl}inquiries/vehicle/image');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Content-Type': 'application/json;',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'vehicle_photo',
        file.readAsBytesSync(),
        filename: fileName.split("/").last,
      ),
    );
    request.fields['inquiry_id'] = inquiryId.toString();
    request.fields['image_type'] = imageType;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String bodyString = await response.stream.bytesToString();
        print(bodyString);
        return ResponseVehicleImage.fromJson(jsonDecode(bodyString));
      } else {
        throw Exception('Something went wrong. Please try again.');
      }
    } catch (e) {
      throw Exception(
        'Something went wrong. Please try again. ${e.toString()}',
      );
    }
  }

  Future<ResponseBankStatement> uploadBankStatement(
    String token,
    File file,
    String fileName,
    String startTime,
    String endTime,
    int inquiryId,
  ) async {
    final uri = Uri.parse('${baseUrl}inquiries/bank-statement');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Content-Type': 'application/json;',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'statement_file',
        file.readAsBytesSync(),
        filename: fileName.split("/").last,
      ),
    );
    request.fields['inquiry_id'] = inquiryId.toString();
    request.fields['statement_start_date'] = startTime;
    request.fields['statement_end_date'] = endTime;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String bodyString = await response.stream.bytesToString();
        print(bodyString);
        return ResponseBankStatement.fromJson(jsonDecode(bodyString));
      } else {
        throw Exception('Something went wrong. Please try again.');
      }
    } catch (e) {
      throw Exception(
        'Something went wrong. Please try again. ${e.toString()}',
      );
    }
  }

  Future<ResponseBillingProof> uploadCustomerBillingProof(
    String token,
    File billFile,
    String fileName,
    String billName,
    String billType,
    int inquiryId,
  ) async {
    final uri = Uri.parse('${baseUrl}inquiries/billing-proof');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Content-Type': 'application/json;',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'bill_file',
        billFile.readAsBytesSync(),
        filename: fileName.split("/").last,
      ),
    );
    request.fields['inquiry_id'] = inquiryId.toString();
    request.fields['bill_name'] = billName;
    request.fields['bill_type'] = billType;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String bodyString = await response.stream.bytesToString();
        print(bodyString);
        return ResponseBillingProof.fromJson(jsonDecode(bodyString));
      } else {
        throw Exception('Something went wrong. Please try again.');
      }
    } catch (e) {
      throw Exception(
        'Something went wrong. Please try again. ${e.toString()}',
      );
    }
  }

  Future<ResponseGuarantorProfile> updateGuarantorDetails(
    String token,
    GuarantorProfile guarantorProfileUpdate,
    int guarantorIndex,
    int inquiryId,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/guarantor/$guarantorIndex'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'inquiry_id': inquiryId,
        'first_name': guarantorProfileUpdate.first_name,
        'last_name': guarantorProfileUpdate.last_name,
        'nic_number': guarantorProfileUpdate.nic,
        'guarantor_occupation': guarantorProfileUpdate.occupation,
        'guarantor_address': guarantorProfileUpdate.address,
        'guarantor_district': guarantorProfileUpdate.district_id,
        'contact_number': guarantorProfileUpdate.contact_number,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseGuarantorProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseBankStatement> uploadGuarantorBankStatement(
    String token,
    File file,
    String fileName,
    String startTime,
    String endTime,
    int inquiryId,
    int guarantorIndex,
  ) async {
    final uri = Uri.parse(
      '${baseUrl}inquiries/guarantor/$guarantorIndex/bank-statement',
    );
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Content-Type': 'application/json;',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'statement_file',
        file.readAsBytesSync(),
        filename: fileName.split("/").last,
      ),
    );
    request.fields['inquiry_id'] = inquiryId.toString();
    request.fields['statement_start_date'] = startTime;
    request.fields['statement_end_date'] = endTime;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String bodyString = await response.stream.bytesToString();
        print(bodyString);
        return ResponseBankStatement.fromJson(jsonDecode(bodyString));
      } else {
        print('Status >> ${response.statusCode}');
        throw Exception('Something went wrong. Please try again.xxx');
      }
    } catch (e) {
      throw Exception(
        'Something went wrong. Please try again>>. ${e.toString()}',
      );
    }
  }

  Future<ResponseBillingProof> uploadGuarantorBillingProof(
    String token,
    File billFile,
    String fileName,
    String billName,
    String billType,
    int inquiryId,
    int guarantorIndex,
  ) async {
    final uri = Uri.parse(
      '${baseUrl}inquiries/guarantor/$guarantorIndex/billing-proof',
    );
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Content-Type': 'application/json;',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.files.add(
      http.MultipartFile.fromBytes(
        'bill_file',
        billFile.readAsBytesSync(),
        filename: fileName.split("/").last,
      ),
    );
    request.fields['inquiry_id'] = inquiryId.toString();
    request.fields['bill_name'] = billName;
    request.fields['bill_type'] = billType;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String bodyString = await response.stream.bytesToString();
        print(bodyString);
        return ResponseBillingProof.fromJson(jsonDecode(bodyString));
      } else {
        throw Exception('Something went wrong. Please try again.');
      }
    } catch (e) {
      throw Exception(
        'Something went wrong. Please try again. ${e.toString()}',
      );
    }
  }

  Future<ResponseFdDetails> updateFdDetails(
    String token,
    int amount,
    String period,
    double rate,
    int inquiryId, {
    required String inquiryType,
  }) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/fd-details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'inquiry_id': inquiryId,
        'amount': amount,
        'period': period,
        'preferred_rate': rate,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseFdDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponsePawningDetails> updateGoldDetails(
    String token,
    int amount,
    String jewelleryDetails,
    String pawnStatus,
    int inquiryId,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/gold-details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'inquiry_id': inquiryId,
        'pawning_essentials_jewellery_details': jewelleryDetails,
        'pawning_amount': amount,
        'pawn_status': pawnStatus,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponsePawningDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseSubmitLease> submitLeaseDetails(
    String token,
    int inquiryId,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/lease/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'inquiry_id': inquiryId}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseSubmitLease.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseSubmitFd> submitFdDetails(
    String token,
    int inquiryId,
    String s,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/fd/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'inquiry_id': inquiryId}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseSubmitFd.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseSubmitInsurance> submitInsuranceDetails(
    String token,
    int inquiryId,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/insurance/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'inquiry_id': inquiryId}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseSubmitInsurance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<ResponseSubmitPawning> submitPawningDetails(
    String token,
    int inquiryId,
  ) async {
    final response = await http.post(
      Uri.parse('${baseUrl}inquiries/gold-loan/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'inquiry_id': inquiryId}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return ResponseSubmitPawning.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}

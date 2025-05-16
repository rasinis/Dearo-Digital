// ignore_for_file: avoid_print

import 'dart:convert';

import '/../models/data/customer_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static late SharedPreferences _preferences;

  static Future<bool> initiatePreferences() async {
    _preferences = await SharedPreferences.getInstance();
    return true;
  }

  static Future<bool> setBearerToken(String? token) async {
    _preferences = await SharedPreferences.getInstance();
    if (token != null) {
      return _preferences.setString('DEARO_TOKEN', token);
    } else {
      return false;
    }
  }

  static Future<String?> getBearerToken() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('DEARO_TOKEN');
  }

  static Future<void> updateCustomerProfile(CustomerProfile customer) async {
    _preferences = await SharedPreferences.getInstance();
    String customerJson = jsonEncode(customer.toMap());
    await _preferences.setString('CUSTOMER', customerJson);
  }

  static Future<CustomerProfile?> getCustomerProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the JSON string from Shared Preferences
    String? customerJson = prefs.getString('CUSTOMER');
    print('>> Saved customer profile $customerJson');

    // If there is no data, return null
    if (customerJson == null) {
      return null;
    }

    // Convert JSON string back to User object
    Map<String, dynamic> customerMap = jsonDecode(customerJson);
    return CustomerProfile.fromJson(customerMap);
  }

  static Future<void> clearSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
  }

  static saveCustomerProfile(CustomerProfile customerProfile) {}

  static saveAuthToken(String s) {}
}

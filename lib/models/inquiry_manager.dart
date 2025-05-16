import 'package:dearo_app/interfaces/inquiry/bank_and_billing_details_form.dart';
import 'package:dearo_app/interfaces/inquiry/bank_g1_form.dart';
import 'package:dearo_app/interfaces/inquiry/bank_g2_form.dart';
import 'package:dearo_app/interfaces/inquiry/gold_loan_inquiry.dart';
import 'package:dearo_app/interfaces/inquiry/gold_loan_inquiry_profile.dart';
import 'package:dearo_app/interfaces/inquiry/guarantor1_form.dart';
import 'package:dearo_app/interfaces/inquiry/guarantor2_form.dart';
import 'package:dearo_app/interfaces/inquiry/in_vehicle_image_form.dart';
import 'package:dearo_app/interfaces/inquiry/insuarance_inquiry.dart';
import 'package:dearo_app/interfaces/inquiry/insuarance_inquiry_profile.dart';
import 'package:dearo_app/interfaces/inquiry/investment_inquiry.dart';
import 'package:dearo_app/interfaces/inquiry/investment_inquiry_profile.dart';
import 'package:dearo_app/interfaces/inquiry/lease_inquiry.dart';
import 'package:dearo_app/interfaces/inquiry/lease_inquiry_profile.dart';
import 'package:dearo_app/interfaces/inquiry/submit_inquiry.dart';
import 'package:dearo_app/interfaces/inquiry/upload_vehicle_proof.dart';
import 'package:dearo_app/models/data/inquiry_record.dart';

import 'package:flutter/material.dart';

class InquiryManager {
  static get inquiryRecord => null;

  /*
  * Leasing States:
  * PROFILE_INCOMPLETE
  * PROFILE_COMPLETED,
  * VEHICLE_ESSENTIALS_ADDED,
  * VEHICLE_IMAGES_ADDED,
  * BANK_BILLING_ADDED,
  * GUARANTOR1_DETAILS_ADDED,
  * GUARANTOR1_SUPPORTING_ADDED,
  * GUARANTOR2_DETAILS_ADDED,
  * GUARANTOR2_SUPPORTING_ADDED
  * */

  static Widget getNextLeasingScreen({
    required String bearerToken,
    required String currentState,
    int inquiryId = 0,
    bool isCustomer = true,
    InquiryRecord? inquiryRecord, 

  }) {
    switch (currentState) {
      case 'PROFILE_INCOMPLETE':
        return LeaseInquiryProForm(
          bearerToken: bearerToken,    
          isInquiryPending: true,
          inquiryType: 'LEASE',
        );
      case 'PROFILE_COMPLETED':
        return LeaseFormScreen(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
          inquiryType: 'LEASE',
        );
      case 'VEHICLE_ESSENTIALS_ADDED':
        return VehiclePhotoProofScreen(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
          inquiryType: 'LEASE',
          inquiryRecord: inquiryRecord,
        );
      case 'VEHICLE_IMAGES_ADDED':
        return BankBillingProofScreen(
          bearerToken: bearerToken,
          isCustomer: isCustomer,
          inquiryId: inquiryId,
          inquiryType: 'LEASE',
        );
      case 'BANK_BILLING_ADDED':
        return Guarantor1Form(
          bearerToken: bearerToken,
          isFirst: true,
          inquiryId: inquiryId,
          inquiryType: 'LEASE',
        );
      case 'GUARANTOR1_DETAILS_ADDED':
        return BankG1Form(
          bearerToken: bearerToken,
          isFirst: true,
          inquiryId: inquiryId,
          inquiryType: 'LEASE',
          isCustomer: isCustomer,
        );
      case 'GUARANTOR1_SUPPORTING_ADDED':
        return Guarantor2Form(
          bearerToken: bearerToken,
          isFirst: false,
          inquiryId: inquiryId,
          inquiryType: 'LEASE',
        );
      case 'GUARANTOR2_DETAILS_ADDED':
        return BankG2Form(
          bearerToken: bearerToken,
          isFirst: false,
          inquiryId: inquiryId,
          inquiryType: 'LEASE',
          isCustomer: isCustomer,
        );
      case 'GUARANTOR2_SUPPORTING_ADDED':
        return SubmitInquiryScreen(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
        );
    }

    return LeaseInquiryProForm(
      bearerToken: bearerToken,
      isInquiryPending: true,
      inquiryType: 'LEASE',
    );
  }

  static String getCurrentLeasingAppState({required String inquiryStep}) {
    switch (inquiryStep) {
      case 'CUSTOMER_PROFILE_ASSIGNED':
        return 'PROFILE_COMPLETED';
      case 'VEHICLE_DETAILS_ADDED':
        return 'VEHICLE_IMAGES_ADDED';
      case 'BANK_DETAILS_ADDED':
        return 'BANK_BILLING_ADDED';
      case 'GUARANTOR_ADDED':
        return 'GUARANTOR1_SUPPORTING_ADDED';
      case 'GUARANTOR2_ADDED':
        return 'GUARANTOR2_SUPPORTING_ADDED';
      default:
        return 'PROFILE_COMPLETED';
    }
  }

  static StatefulWidget getNextFdScreen({
    required String bearerToken,
    required String currentState,
    int inquiryId = 0,
  }) {
    switch (currentState) {
      case 'PROFILE_INCOMPLETE':
        return InvestmentInquiryProForm(
          bearerToken: bearerToken,
          isInquiryPending: true,
          inquiryType: 'FD',
        );
      case 'PROFILE_COMPLETED':
        return InvestmentForm(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
          inquiryType: 'FD',
          currentState: currentState,
          currentStte: '',
        );
      case 'FD_DETAILS_ADDED':
        return SubmitInquiryScreen(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
        );
    }

    return InvestmentInquiryProForm(
      bearerToken: bearerToken,
      isInquiryPending: true,
      inquiryType: 'FD',
    );
  }

  static String getCurrentFdAppState({required String inquiryStep}) {
    switch (inquiryStep) {
      case 'CUSTOMER_PROFILE_ASSIGNED':
        return 'PROFILE_COMPLETED';
      case 'FD_DETAILS_ADDED':
        return 'FD_DETAILS_ADDED';
      default:
        return 'PROFILE_COMPLETED';
    }
  }

  static StatefulWidget getNextInsuranceScreen({
    required String bearerToken,
    required String currentState,
    int inquiryId = 0,
  }) {
    switch (currentState) {
      case 'PROFILE_INCOMPLETE':
        return InsuaranceInquiryProForm(
          bearerToken: bearerToken,
          isInquiryPending: true,
          inquiryType: 'INSURANCE',
        );
      case 'PROFILE_COMPLETED':
        return InsuaranceFormScreen(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
          inquiryType: 'INSURANCE',
        );
      case 'VEHICLE_ESSENTIALS_ADDED':
        return VehiclePhotoProofInScreen(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
          inquiryType: 'INSURANCE',
        );
      case 'VEHICLE_IMAGES_ADDED':
        return SubmitInquiryScreen(
          bearerToken: bearerToken,
          inquiryId: inquiryId,
        );
    }
    return InsuaranceInquiryProForm(
      bearerToken: bearerToken,
      isInquiryPending: true,
      inquiryType: 'INSURANCE',
    );
  }

  static String getCurrentInsuranceAppState({required String inquiryStep}) {
    switch (inquiryStep) {
      case 'CUSTOMER_PROFILE_ASSIGNED':
        return 'PROFILE_COMPLETED';
      case 'VEHICLE_DETAILS_ADDED':
        return 'VEHICLE_IMAGES_ADDED';
      case 'INSURANCE_DETAILS_ADDED':
        return 'INSURANCE_DETAILS_ADDED';
      default:
        return 'PROFILE_COMPLETED';
    }
  }

  static StatefulWidget getNextPawningScreen({
    required String bearerToken,
    required String currentState,
    int inquiryId = 0,
  }) {
    switch (currentState) {
      case 'PROFILE_INCOMPLETE':
        return GoldLoanInquiryProForm(
          bearerToken: bearerToken,
          isInquiryPending: true,
          inquiryType: 'FD',
        );
      case 'PROFILE_COMPLETED':
        return GoldLoanForm(bearerToken: bearerToken, inquiryId: inquiryId);
      case 'PAWN_DETAILS_ADDED':
    }

    return GoldLoanInquiryProForm(
      bearerToken: bearerToken,
      isInquiryPending: true,
      inquiryType: 'FD',
    );
  }

  static String getCurrentPawningAppState({required String inquiryStep}) {
    switch (inquiryStep) {
      case 'CUSTOMER_PROFILE_ASSIGNED':
        return 'PROFILE_COMPLETED';
      case 'PAWN_DETAILS_ADDED':
        return 'PAWN_DETAILS_ADDED';
      case 'BANK_DETAILS_ADDED':
        return 'BANK_BILLING_ADDED';
      default:
        return 'PROFILE_COMPLETED';
    }
  }
}

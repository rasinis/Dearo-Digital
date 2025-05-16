// ignore_for_file: non_constant_identifier_names

import '../../models/data/bank_statement.dart';

class ResponseBankStatement{
  final bool error;
  final String message;
  final BankStatement? bank_statement;
  final bool statements_ready;
  final String? missing_statements;

  ResponseBankStatement({

    
    required this.error,
    required this.message, 
    required this.bank_statement,
    required this.statements_ready,
    required this.missing_statements
  });

  factory ResponseBankStatement.fromJson(Map<String, dynamic> json){
    late ResponseBankStatement responseBankStatement;

    try{
      responseBankStatement = ResponseBankStatement(
        error: json['error'],
        message: json['message'],
        bank_statement: BankStatement.fromJson(json['bank_statement']),
        statements_ready: json['statements_ready'],
        missing_statements: json['missing_statements'],
      );

      return responseBankStatement;
    }catch(e){
      return ResponseBankStatement(
        error: true,
        message: e.toString(),
        bank_statement: null,
        statements_ready: false,
        missing_statements: null
      );
    }
  }

  get billing_proof => null;

  get bill_name => null;

  get bill_type => null;
}
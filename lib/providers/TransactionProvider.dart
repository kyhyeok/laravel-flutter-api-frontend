import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/models/Transaction.dart';
import 'package:flutter_api_frontend/providers/AuthProvider.dart';
import 'package:flutter_api_frontend/services/api.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> transactions = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  TransactionProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);

    init();
  }

  Future init() async {
    transactions = await apiService.fetchTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(String amount, String category, String description, String date) async {
    try {
      Transaction addedTransaction = await apiService.addTransaction(amount, category, description, date);
      transactions.add(addedTransaction);
    } catch (Exception) {
      print(Exception);
    }
  }

  Future<void> updateTransaction(Transaction transaction) async {
    try {
      Transaction updatedTransaction = await apiService.updateTransaction(transaction);
      int index = transactions.indexOf(transaction);
      transactions[index] = updatedTransaction;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future<void> deleteTransaction(Transaction transaction) async {
    try {
      await apiService.deleteTransaction(transaction.id);
    } catch (Exception) {
      print(Exception);
    }
  }
}
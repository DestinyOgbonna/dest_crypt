import 'dart:developer';

import 'package:dest_crypt/src/features/dashboard/data/dashboard_data.dart';
import 'package:dest_crypt/src/model/coins_list_model.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardData _dashboardData = DashboardData();
  List<CoinstListModel> coinsList = [];

  LoadingState loadState = LoadingState.idle;

  Future<void> getCoins() async {
    try {
      loadState = LoadingState.loading;
      notifyListeners();
      final getCoins = await _dashboardData.getCoins();
      loadState = LoadingState.success;
      notifyListeners();
      if (getCoins['Success']) {
        List coins = getCoins['data'];
        final coinsDatea = coins
            .map((e) => CoinstListModel.fromJson(e))
            .toList();
        coinsList = coinsDatea;
        notifyListeners();
      } else {
        loadState = LoadingState.failed;
        notifyListeners();
      }
    } catch (e) {
      log(" ERROR $e");
      loadState = LoadingState.failed;
      notifyListeners();
    }
  }
}

enum LoadingState { loading, success, failed, idle }

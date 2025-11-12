import 'dart:developer';

import 'package:dest_crypt/src/features/coin_details/data/coin_details_data.dart';
import 'package:dest_crypt/src/features/dashboard/data/dashboard_provider.dart';
import 'package:dest_crypt/src/model/chart_data_model.dart';

import 'package:flutter/widgets.dart';

class CoinDetailsProvider extends ChangeNotifier {
  final CoinDetailsData _detailsData = CoinDetailsData();
  LoadingState loadState = LoadingState.idle;

  Future<void> getCoins({required String id}) async {
    try {
      loadState = LoadingState.loading;
      notifyListeners();

      final getCoins = await _detailsData.getCoinsDetails(
        id: id,
        fromTime: 1762688016,
        toTime: 1762860816,
      );

      if (getCoins['Success']) {
        // The API returns a single object, not a list
        final chartData = ChartDataModel.fromJson(getCoins['data']);

        // Convert to chart points for easier usage
        coinData = chartData.toChartPoints();

        log('THIS IS DATA: ${coinData.length} points loaded');

        loadState = LoadingState.success;
        notifyListeners();
      } else {
        loadState = LoadingState.failed;
        notifyListeners();
      }
    } catch (e) {
      log("ERROR: $e");
      loadState = LoadingState.failed;
      notifyListeners();
    }
  }

  
  List<ChartDataPoint> coinData = [];
}

import 'package:dest_crypt/services/api_services/api_service.dart';

class CoinDetailsData {
  final DestCryptAPi _cryptAPi = DestCryptAPi();

  Future<Map<String, dynamic>> getCoinsDetails({
    required String id,
    required num fromTime,
    required num toTime,
  }) async {
    final response = await _cryptAPi.get(
      path: '/coins/$id/market_chart/range',
      isQueryParams: true,
      returnAsList: false,
      queryParams: {'vs_currency': 'usd', "from": fromTime, "to": toTime},
    );

    if (response.$1 == true) {
      return {'Success': true, 'data': response.$2};
    } else {
      return {'Success': false, 'message': response.$2.first['message']};
    }
  }
}

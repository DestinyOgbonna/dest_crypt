import 'package:dest_crypt/services/api_services/api_service.dart';

class DashboardData {
  final DestCryptAPi _cryptAPi = DestCryptAPi();
  Future<Map<String, dynamic>> getCoins() async {
    final response = await _cryptAPi.get(
      path: '/coins/markets',
      returnAsList: true,
      isQueryParams: true,
      queryParams: {'vs_currency': 'usd'},
    );

    if (response.$1 == true) {
      return {'Success': true, 'data': response.$2};
    } else {
      return {'Success': false, 'message': response.$2.first['message']};
    }
  }
}

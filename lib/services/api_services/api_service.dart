import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _destCryptClient = Dio(BaseOptions());

class DestCryptAPi {
  final baseUrl = dotenv.get('BASE_URL');
  
  final apiKey = dotenv.get('API_KEY');

  Future<(String?, Map<String, dynamic>)> post({
    required String urlPath,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await _destCryptClient.post(
        "$baseUrl$urlPath",
        data: body,
        options: Options(headers: {'x-cg-demo-api-key': apiKey}),
      );
      log(
        "Sending a POST request to $baseUrl$urlPath\n$body from the POST client",
      );
      Map<String, dynamic> apiResponse;
      if (response.data is Map) {
        apiResponse = response.data;
      } else {
        apiResponse = jsonDecode(response.data);
      }
      log('Runtype => ${apiResponse.runtimeType}');
      return (response.statusMessage, apiResponse);
    } on DioException catch (e) {
      handleApiError(e);
      final Map<String, dynamic> data;
      if (e.response?.data is Map<String, dynamic>) {
        data = e.response?.data ?? {};
      } else {
        data = jsonDecode("${e.response?.data ?? '{}'}");
      }
      return (
        e.response?.statusMessage,
        <String, dynamic>{"message": data['message'] ?? 'An error occurred'},
      );
    }
  }

  Future<(bool isSuccessful, dynamic data)> get({
    required String path,
    Map<String, dynamic>? queryParams,
    bool isQueryParams = false,

    bool returnAsList = true,
  }) async {
    log("Sending a GET request to $path");

    try {
      final response = await _destCryptClient.get(
        "$baseUrl$path",
        options: Options(headers: {'x-cg-demo-api-key': apiKey}),
        queryParameters: isQueryParams ? queryParams : null,
      );

      log("Sending a GET request to $baseUrl$path");

      if (response.data == null) {
        return returnAsList
            ? (
                false,
                [
                  <String, dynamic>{"message": "The data is null."},
                ],
              )
            : (false, <String, dynamic>{"message": "The data is null."});
      }
      dynamic apiResponse;
      if (response.data is Map) {
        apiResponse = response.data;
      } else if (response.data is List) {
        apiResponse = response.data;
      } else {
        apiResponse = jsonDecode(response.data);
      }
      if (returnAsList && apiResponse is! List) {
        apiResponse = [apiResponse];
      } else if (!returnAsList && apiResponse is List) {
        apiResponse = apiResponse.isNotEmpty ? apiResponse.first : {};
      }
      return (true, apiResponse);
    } on DioException catch (e) {
      log("Dio Exception Response");
      handleApiError(e);
      if (e.response?.data == null) {
        return returnAsList
            ? (
                false,
                [
                  <String, dynamic>{"message": "The data is null."},
                ],
              )
            : (false, <String, dynamic>{"message": "The data is null."});
      }

      final Map<String, dynamic> result;
      if (e.response?.data is Map<String, dynamic>) {
        result = e.response?.data;
      } else {
        result = jsonDecode(e.response?.data);
      }

      return returnAsList
          ? (
              false,
              [
                <String, dynamic>{"message": result['message']},
              ],
            )
          : (false, <String, dynamic>{"message": result['message']});
    }
  }

  void handleApiError(DioException e) {
    if (e.type == DioExceptionType.cancel) {
      if (kDebugMode) {
        print(">>DIO ERROR<<: Request to ${e.requestOptions.uri} was canceled");
      }
    } else if (e.type == DioExceptionType.connectionTimeout) {
      if (kDebugMode) {
        print(">>DIO ERROR<<: Connection timeout to ${e.requestOptions.uri}");
      }
    } else if (e.type == DioExceptionType.sendTimeout) {
      if (kDebugMode) {
        print(">>DIO ERROR<<: Send timeout to ${e.requestOptions.uri}");
      }
    } else if (e.type == DioExceptionType.receiveTimeout) {
      if (kDebugMode) {
        print(">>DIO ERROR<<: Receive timeout from ${e.requestOptions.uri}");
      }
    } else if (e.type == DioExceptionType.badResponse) {
      if (kDebugMode) {
        print(
          ">>DIO ERROR<<: Response error. Status code: ${e.response?.statusCode}",
        );
      }
      if (e.response?.statusCode == 401) {
        if (kDebugMode) {
          print(
            ">>DIO ERROR<<: Unauthorized access. Redirecting to login screen.",
          );
        }
        // Add your navigation logic here
      } else {
        if (kDebugMode) {
          print(">>DIO ERROR<<: Response data: ${e.response?.data}");
        }
      }
    } else if (e.type == DioExceptionType.unknown) {
      if (kDebugMode) {
        print(">>DIO ERROR<<: Other Dio error occurred");
      }
    } else if (e.type == DioExceptionType.badCertificate) {
      if (kDebugMode) {
        print(">>DIO ERROR<<: Bad certificate from ${e.requestOptions.uri}");
      }
    }
  }
}

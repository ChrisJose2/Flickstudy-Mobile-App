import 'dart:convert';

import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:http/http.dart' as http;

class BaseService {
  static const String baseUrl = AppConstants.BASE_URL;

  static Future<bool> checkInternetConnectivity() async {
    return true;
    /*final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.vpn;*/
  }

  static Future<dynamic> post(String endpoint, dynamic body) async {
    Map<String, dynamic> responseData;
    try {
      if (await checkInternetConnectivity()) {
        final response = await http.post(
          Uri.parse(baseUrl + endpoint),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          responseData = json.decode(response.body);
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to post data: $e');
    }
    return responseData;
  }

  static Future<dynamic> get(String endpoint) async {
    Map<String, dynamic> responseData;
    try {
      if (await checkInternetConnectivity()) {
        final response = await http.get(
          Uri.parse(baseUrl + endpoint),
        );
        if (response.statusCode == 200) {
          responseData = json.decode(response.body);
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to get data: $e');
    }
    return responseData;
  }

  static Future<Map<String, dynamic>> rawGet(String endpoint) async {
    Map<String, dynamic> responseData;
    try {
      if (await checkInternetConnectivity()) {
        final response = await http.get(
          Uri.parse(endpoint),
        );
        if (response.statusCode == 200) {
          responseData = json.decode(response.body);
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to get data: $e');
    }
    return responseData;
  }

  static Future<dynamic> put(String endpoint, dynamic body) async {
    Map<String, dynamic> responseData;
    try {
      if (await checkInternetConnectivity()) {
        final response = await http.put(
          Uri.parse(baseUrl + endpoint),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          responseData = json.decode(response.body);
        } else {
          throw Exception('Failed to update data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to put data: $e');
    }
    return responseData;
  }

  static Future<dynamic> delete(String endpoint, dynamic body) async {
    Map<String, dynamic> responseData;
    try {
      if (await checkInternetConnectivity()) {
        final response = await http.delete(
          Uri.parse(baseUrl + endpoint),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          responseData = json.decode(response.body);
        } else {
          throw Exception('Failed to delete data');
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to delete data: $e');
    }
    return responseData;
  }
}

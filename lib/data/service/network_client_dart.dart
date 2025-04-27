import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import '../../app.dart';
import '../../view/auth/login_screen.dart';
import '../controller/auth_controller.dart';

//ai class create korecchi jno http ar response k bar bar call korte na hoi
class NetworkResponse {
  //response a ki ki thake?
  //response success hoise kina ?
  final bool isSuccess;
  //response ar status code
  final int statusCode;
  //response ar body
  final Map<String, dynamic>? data;
  //response ar status code
  final String errorMessage;

  //network response ar instance create korlam
  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkClient {
  //logger debug korar jonno use kora hoi ati print  ar moto kaj kore
  //logger ar instance create korechi
  static final Logger _logger = Logger();

  //aita akta get Request data get korar jonno use kora hoi ati return kore
  //NetworkResponse
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.token ?? '',
      };
      _preRequestLog(url, headers);
      Response response = await get(uri, headers: headers);
      _postRequestLog(url, response.statusCode, headers: response.headers, responseBody: response.body);
      if (response.statusCode == 200) {
        //jsonEncode string hisebe ase.string nia dart kaj kortepare na .tai ai string k map,list a decoded kori
        //jno dart sohoje kaj korte pare
        final decodedJson = jsonDecode(response.body);

        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            data: decodedJson);
      } else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Un-authorize user. Please login again.'
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something went wrong';
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessage);
      }
    } catch (e) {
      //jkono error aste pare unexpected error handel korar jonno catch use kori
      //status code nai tai -1 use kori
      _postRequestLog(url, -1);
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'Application/json',
        'token': AuthController.token ?? '',
      };
      _preRequestLog(url, headers, body: body);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _postRequestLog(url, response.statusCode,
          headers: response.headers, responseBody: response.body);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            data: decodedJson);
      } else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Un-authorize user. Please login again.'
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something went wrong';
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessage);
      }
    } catch (e) {
      _postRequestLog(url, -1, errorMessage: e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }


  //response success howar age agulo print korbe
  static void _preRequestLog(String url, Map<String, String> headers, {Map<String, dynamic>? body}) {
    _logger.i('URL => $url\nHeaders: $headers\n'
        'Body: $body');
  }

  //success howar pore aigulo print korbe ar
  static void _postRequestLog(String url, int statusCode, {Map<String, dynamic>? headers,
        dynamic responseBody,
        dynamic errorMessage}) {
    //jodi response error ase tahole ai message show korbe
    if (errorMessage != null) {
      _logger.e(''
          'Url: $url\n'
          'Status code: $statusCode\n'
          'Error Message: $errorMessage');
    } else {
      //jodi response success hoi tahole ai message print korbe
      _logger.i(''
          'Url: $url\n'
          'Status code: $statusCode\n'
          'Headers: $headers\n'
          'Response: $responseBody');
    }
  }

  static Future<void> _moveToLoginScreen() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManage.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (predicate) => false);
  }
}

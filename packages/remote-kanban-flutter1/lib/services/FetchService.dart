import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test_fl_kanban/constants/Api.dart';
import 'package:test_fl_kanban/constants/RequestMethods.dart';
import 'package:test_fl_kanban/entities/CommonError.dart';
import 'package:test_fl_kanban/services/AuthService.dart';

AuthService authService = AuthService();

// ignore: unused_element
class TokenMap {
  static String appLivingToken;
  String token;
}

class FetchService {
  static Future<Response<T>> fetch<T>(
      {Map<String, String> body,
      @required String requestMethod,
      @required String url,
      bool checkToken = true,
      Map<String, String> urlSearchParams}) async {
    // Headers
    Map<String, String> headers = {};
    _addTokenToHeaders(String token) {
      if (token == null) return;
      headers[HttpHeaders.authorizationHeader] = token;
      // TODO: save to shared preferences
      TokenMap.appLivingToken = token;
    }

    // Add token function
    Future<void> checkAndRefreshToken() async {
      String token = await AuthService.getLocalToken();

      if (token != null && token.isNotEmpty) {
        var resp = await authService.refreshToken(
          token: AuthService.cleanToken(token),
        );

        if (resp.statusCode < 305) {
          String newRawToken = resp.data['token'];
          if (newRawToken == null) return;
          String newToken = AuthService.createToken(newRawToken);
          _addTokenToHeaders(newToken);
        }
      }
    }

    if (checkToken) {
      await checkAndRefreshToken();
    } else {
      String token = await AuthService.getLocalToken();

      _addTokenToHeaders(token);
    }
    Uri uri = Uri.https(Api.authority, url, urlSearchParams);
    // FormData formData = FormData.fromMap(body);
    Dio dio = Dio();
    Options options = Options()..headers = headers;
    var response = await (() async {
      try {
        switch (requestMethod) {
          case RequestMethods.post:
            return await dio.postUri(uri, data: body, options: options);
          case RequestMethods.getRequest:
            return await dio.getUri(uri, options: options);
          case RequestMethods.delete:
            return await dio.deleteUri(uri, options: options);
          case RequestMethods.patch:
            return await dio.patchUri(uri, data: body, options: options);
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response.statusCode == 500) {
            throw CommonError(message: e.response.data);
          }
          throw CommonError(
            response: e.response,
          );
        } else {
          throw CommonError(message: e.message);
        }
      }
    })();

    return response;
  }
}

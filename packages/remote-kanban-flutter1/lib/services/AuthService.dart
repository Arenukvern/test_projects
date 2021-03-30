import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test_fl_kanban/constants/Api.dart';
import 'package:test_fl_kanban/constants/RequestMethods.dart';
import 'package:test_fl_kanban/entities/CommonError.dart';
import 'package:test_fl_kanban/entities/User.dart';
import 'package:test_fl_kanban/services/FetchService.dart';

class AuthService {
  Future<UserError> login(User user) async {
    try {
      var response = await FetchService.fetch(
          body: {'username': user.username, 'password': user.password},
          requestMethod: RequestMethods.post,
          url: Api.usersLogin);

      //TODO: save token to shared preferences
      String token = response.data['token'];
      if (token == null) throw CommonError(message: 'Token is null!');
      TokenMap.appLivingToken = AuthService.createToken(token);
      return null;
    } on CommonError catch (e) {
      return UserError(commonError: e);
    }
  }

  Future<Response<dynamic>> refreshToken({String token}) async {
    return await FetchService.fetch(
        body: {'token': token},
        requestMethod: RequestMethods.post,
        url: Api.usersRefreshToken,
        checkToken: false);
  }

  // TODO: add shared preferences
  static Future<String> getLocalToken() async => TokenMap.appLivingToken;

  static String cleanToken(String token) => token.replaceAll('JWT ', '');
  static String createToken(String token) => 'JWT $token';
}

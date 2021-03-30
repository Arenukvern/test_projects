import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_fl_kanban/entities/CommonError.dart';

part 'User.g.dart';

class User {
  String password;
  String username;
  String token;
  String id;
  User({this.id, this.password, this.token, this.username});
}

@JsonSerializable()
class UserErrors {
  List<String> password;
  List<String> username;
  List<String> token;
  UserErrors();
  factory UserErrors.fromJson(Map<String, dynamic> json) =>
      _$UserErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$UserErrorsToJson(this);
}

class UserError {
  CommonError commonError;
  UserError({@required this.commonError});
  String get nonFieldErrors {
    try {
      if (this.commonError.response == null) return '';
      var pr = commonError?.response?.data['non_field_errors'][0];
      return pr;
    } catch (e) {
      return '';
    }
  }

  UserErrors get user {
    if (this.commonError.response == null) return UserErrors();
    try {
      UserErrors errors = UserErrors.fromJson(this.commonError.response.data);
      return errors;
    } catch (e) {
      return UserErrors();
    }
  }
}

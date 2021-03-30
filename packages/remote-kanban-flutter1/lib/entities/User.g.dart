// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserErrors _$UserErrorsFromJson(Map<String, dynamic> json) {
  return UserErrors()
    ..password = (json['password'] as List)?.map((e) => e as String)?.toList()
    ..username = (json['username'] as List)?.map((e) => e as String)?.toList()
    ..token = (json['token'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$UserErrorsToJson(UserErrors instance) =>
    <String, dynamic>{
      'password': instance.password,
      'username': instance.username,
      'token': instance.token,
    };

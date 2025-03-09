import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

/// 基于 `assets/json/login.json` 生成 `login_model.dart`

@JsonSerializable()
class LoginModel {
  final String id;
  final String name;

  LoginModel({
    required this.id,
    required this.name,
  });

  // 反序列化：将 Map 数据转换为 LoginModel 实例
  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  // 序列化：将 LoginModel 实例转换为 Map 数据
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

}

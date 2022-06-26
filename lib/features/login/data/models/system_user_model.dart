import 'package:payroll_system/features/login/domain/entities/system_user.dart';

class SystemUserModel extends SystemUser {
  SystemUserModel({
    required super.id,
    required super.name,
    required super.lastLogin,
    required super.roleId,
    super.token,
    super.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastLogin': lastLogin.millisecondsSinceEpoch,
      'roleId': roleId,
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  factory SystemUserModel.fromMap(Map<String, dynamic> map) {
    return SystemUserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      lastLogin: DateTime.parse(map['lastLogin'] ?? DateTime.now().toString()),
      roleId: map['roleId'] as int,
      token: map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
    );
  }

  @override
  String toString() {
    return 'SystemUser(id: $id, name: $name, lastLogin: $lastLogin, roleId: $roleId, token: $token, refreshToken: $refreshToken)';
  }
}

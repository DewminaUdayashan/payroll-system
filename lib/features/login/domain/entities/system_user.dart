class SystemUser {
  final int id;
  final String name;
  final DateTime lastLogin;
  final int roleId;
  final String? token;
  final String? refreshToken;

  SystemUser({
    required this.id,
    required this.name,
    required this.lastLogin,
    required this.roleId,
    this.token,
    this.refreshToken,
  });
}

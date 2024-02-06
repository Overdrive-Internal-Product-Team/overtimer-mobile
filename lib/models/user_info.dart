import 'package:overtimer_mobile/models/role_info.dart';

class UserInfo {
  const UserInfo(
      {required this.id,
      required this.name,
      required this.email,
      required this.active,
      required this.role});

  final int id;
  final String name;
  final String email;
  final bool active;
  final RoleInfo role;
}

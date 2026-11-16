import '../../data/models/user_authorization_model.dart';

const Set<String> adminAuthorityLevels = <String>{'super', 'admin'};

class UserAuthorizationEntity {
  const UserAuthorizationEntity({
    required this.id,
    this.userId,
    this.userStaffId,
    this.authorityLevel,
  });

  final String id;
  final String? userId;
  final String? userStaffId;
  final String? authorityLevel;

  bool get canAccessAdminPanel {
    final level = authorityLevel;
    return level != null && adminAuthorityLevels.contains(level);
  }

  factory UserAuthorizationEntity.fromModel(UserAuthorizationModel model) {
    return UserAuthorizationEntity(
      id: model.id,
      userId: model.userId,
      userStaffId: model.userStaffId,
      authorityLevel: model.authorityLevel,
    );
  }

  UserAuthorizationModel toModel() {
    return UserAuthorizationModel(
      id: id,
      userId: userId,
      userStaffId: userStaffId,
      authorityLevel: authorityLevel,
    );
  }
}

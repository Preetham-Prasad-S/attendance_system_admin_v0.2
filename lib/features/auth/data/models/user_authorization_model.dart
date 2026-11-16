class UserAuthorizationModel {
  const UserAuthorizationModel({
    required this.id,
    this.userId,
    this.userStaffId,
    this.authorityLevel,
  });

  final String id;
  final String? userId;
  final String? userStaffId;
  final String? authorityLevel;

  factory UserAuthorizationModel.fromJson(Map<String, dynamic> json) {
    return UserAuthorizationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      userStaffId: json['user_staff_id'] as String?,
      authorityLevel: json['authority_level'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'user_staff_id': userStaffId,
    'authority_level': authorityLevel,
  };
}

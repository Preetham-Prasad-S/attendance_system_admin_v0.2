import '../../data/models/staff_model.dart';

class StaffEntity {
  const StaffEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.staffId,
    required this.instituteId,
    required this.department,
    required this.position,
    required this.status,
    this.phoneNo,
    this.userId,
    this.authorityLevel,
  });

  final String id;
  final String name;
  final String email;
  final String staffId;
  final String instituteId;
  final String department;
  final String position;
  final bool status;
  final int? phoneNo;
  final String? userId;

  /// Joined from `user_authorization`; not persisted on the staff record.
  final String? authorityLevel;

  factory StaffEntity.fromModel(StaffModel model) => StaffEntity(
    id: model.id,
    name: model.name,
    email: model.email,
    staffId: model.staffId,
    instituteId: model.instituteId,
    department: model.department,
    position: model.position,
    status: model.status,
    phoneNo: model.phoneNo,
    userId: model.userId,
  );

  StaffModel toModel() => StaffModel(
    id: id,
    name: name,
    email: email,
    staffId: staffId,
    instituteId: instituteId,
    department: department,
    position: position,
    status: status,
    phoneNo: phoneNo,
    userId: userId,
  );

  StaffEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? staffId,
    String? instituteId,
    String? department,
    String? position,
    bool? status,
    int? phoneNo,
    String? userId,
    String? authorityLevel,
  }) {
    return StaffEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      staffId: staffId ?? this.staffId,
      instituteId: instituteId ?? this.instituteId,
      department: department ?? this.department,
      position: position ?? this.position,
      status: status ?? this.status,
      phoneNo: phoneNo ?? this.phoneNo,
      userId: userId ?? this.userId,
      authorityLevel: authorityLevel ?? this.authorityLevel,
    );
  }

  @override
  String toString() {
    return 'StaffEntity{id: $id, name: $name, email: $email, staffId: $staffId, instituteId: $instituteId, department: $department, position: $position, status: $status, phoneNo: $phoneNo, userId: $userId, authorityLevel: $authorityLevel}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaffEntity &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.staffId == staffId &&
        other.instituteId == instituteId &&
        other.department == department &&
        other.position == position &&
        other.status == status &&
        other.phoneNo == phoneNo &&
        other.userId == userId &&
        other.authorityLevel == authorityLevel;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      staffId.hashCode ^
      instituteId.hashCode ^
      department.hashCode ^
      position.hashCode ^
      status.hashCode ^
      phoneNo.hashCode ^
      userId.hashCode ^
      authorityLevel.hashCode;
}

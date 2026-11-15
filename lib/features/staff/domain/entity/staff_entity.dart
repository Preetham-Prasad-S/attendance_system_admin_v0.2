import '../../data/models/staff_model.dart';

class StaffEntity {
  const StaffEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.staffId,
    required this.department,
    required this.position,
    required this.status,
    this.phoneNo,
  });

  final String id;
  final String name;
  final String email;
  final String staffId;
  final String department;
  final String position;
  final bool status;
  final int? phoneNo;

  factory StaffEntity.fromModel(StaffModel model) => StaffEntity(
    id: model.id,
    name: model.name,
    email: model.email,
    staffId: model.staffId,
    department: model.department,
    position: model.position,
    status: model.status,
    phoneNo: model.phoneNo,
  );

  StaffModel toModel() => StaffModel(
    id: id,
    name: name,
    email: email,
    staffId: staffId,
    department: department,
    position: position,
    status: status,
    phoneNo: phoneNo,
  );

  StaffEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? staffId,
    String? department,
    String? position,
    bool? status,
    int? phoneNo,
  }) {
    return StaffEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      staffId: staffId ?? this.staffId,
      department: department ?? this.department,
      position: position ?? this.position,
      status: status ?? this.status,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  @override
  String toString() {
    return 'StaffEntity{id: $id, name: $name, email: $email, staffId: $staffId, department: $department, position: $position, status: $status, phoneNo: $phoneNo}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaffEntity &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.staffId == staffId &&
        other.department == department &&
        other.position == position &&
        other.status == status &&
        other.phoneNo == phoneNo;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      staffId.hashCode ^
      department.hashCode ^
      position.hashCode ^
      status.hashCode ^
      phoneNo.hashCode;
}

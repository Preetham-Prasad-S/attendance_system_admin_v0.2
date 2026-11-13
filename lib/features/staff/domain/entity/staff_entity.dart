import '../../data/models/staff_model.dart';

class StaffEntity {
  const StaffEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.staffId,
    required this.department,
    required this.position,
    this.phoneNo,
  });

  final int id;
  final String name;
  final String email;
  final String staffId;
  final String department;
  final String position;
  final int? phoneNo;

  factory StaffEntity.fromModel(StaffModel model) => StaffEntity(
        id: model.id,
        name: model.name,
        email: model.email,
        staffId: model.staffId,
        department: model.department,
        position: model.position,
        phoneNo: model.phoneNo,
      );

  StaffModel toModel() => StaffModel(
        id: id,
        name: name,
        email: email,
        staffId: staffId,
        department: department,
        position: position,
        phoneNo: phoneNo,
      );

  @override
  String toString() {
    return 'StaffEntity{id: $id, name: $name, email: $email, staffId: $staffId, department: $department, position: $position, phoneNo: $phoneNo}';
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
        other.phoneNo == phoneNo;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ staffId.hashCode ^ department.hashCode ^ position.hashCode ^ phoneNo.hashCode;
}
class StaffModel {
  const StaffModel({
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

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    staffId: json['staff_id'] as String,
    department: json['department'] as String,
    position: json['position'] as String,
    status: json['status'] as bool? ?? true,
    phoneNo: json['phone_no'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'staff_id': staffId,
    'department': department,
    'position': position,
    'status': status,
    'phone_no': phoneNo,
  };

  @override
  String toString() {
    return 'StaffModel{id: $id, name: $name, email: $email, staffId: $staffId, department: $department, position: $position, status: $status, phoneNo: $phoneNo}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaffModel &&
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

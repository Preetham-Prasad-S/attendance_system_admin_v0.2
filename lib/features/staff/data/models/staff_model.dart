class StaffModel {
  const StaffModel({
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

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    staffId: json['staff_id'] as String,
    instituteId: json['institute_id'] as String? ?? '',
    department: json['department'] as String,
    position: json['position'] as String,
    status: json['status'] as bool? ?? true,
    phoneNo: json['phone_no'] as int?,
    userId: json['user_id'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'staff_id': staffId,
    'institute_id': instituteId,
    'department': department,
    'position': position,
    'status': status,
    'phone_no': phoneNo,
    'user_id': userId,
  };

  @override
  String toString() {
    return 'StaffModel{id: $id, name: $name, email: $email, staffId: $staffId, instituteId: $instituteId, department: $department, position: $position, status: $status, phoneNo: $phoneNo, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaffModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.staffId == staffId &&
        other.instituteId == instituteId &&
        other.department == department &&
        other.position == position &&
        other.status == status &&
        other.phoneNo == phoneNo &&
        other.userId == userId;
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
      userId.hashCode;
}

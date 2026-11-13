class StaffModel {
  const StaffModel({
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

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        staffId: json['staff_id'] as String,
        department: json['department'] as String,
        position: json['position'] as String,
        phoneNo: json['phone_no'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'staff_id': staffId,
        'department': department,
        'position': position,
        'phone_no': phoneNo,
      };

  @override
  String toString() {
    return 'StaffModel{id: $id, name: $name, email: $email, staffId: $staffId, department: $department, position: $position, phoneNo: $phoneNo}';
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
        other.phoneNo == phoneNo;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ staffId.hashCode ^ department.hashCode ^ position.hashCode ^ phoneNo.hashCode;
}
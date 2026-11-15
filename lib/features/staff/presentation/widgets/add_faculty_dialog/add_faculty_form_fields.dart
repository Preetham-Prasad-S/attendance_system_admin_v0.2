import 'package:flutter/material.dart';

import '../../controller/staff_state.dart';
import 'add_faculty_dropdown_field.dart';
import 'add_faculty_field.dart';
import 'add_faculty_form_grid.dart';
import 'add_faculty_options.dart';
import 'add_faculty_text_field.dart';

class AddFacultyFormFields extends StatelessWidget {
  const AddFacultyFormFields({
    super.key,
    required this.fullNameController,
    required this.employeeIdController,
    required this.emailController,
    required this.contactController,
    required this.department,
    required this.designation,
    required this.isActive,
    required this.onDepartmentChanged,
    required this.onDesignationChanged,
    required this.onStatusChanged,
    required this.fullNameValidator,
    required this.employeeIdValidator,
    required this.emailValidator,
    required this.contactValidator,
  });

  final TextEditingController fullNameController;
  final TextEditingController employeeIdController;
  final TextEditingController emailController;
  final TextEditingController contactController;
  final String department;
  final String designation;
  final bool isActive;
  final ValueChanged<String?> onDepartmentChanged;
  final ValueChanged<String?> onDesignationChanged;
  final ValueChanged<bool> onStatusChanged;
  final FormFieldValidator<String> fullNameValidator;
  final FormFieldValidator<String> employeeIdValidator;
  final FormFieldValidator<String> emailValidator;
  final FormFieldValidator<String> contactValidator;

  @override
  Widget build(BuildContext context) {
    return AddFacultyFormGrid(
      children: [
        AddFacultyField(
          label: 'Full name',
          isRequired: true,
          child: AddFacultyTextField(
            controller: fullNameController,
            hintText: 'e.g. Dr. Jane Doe',
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            validator: fullNameValidator,
          ),
        ),
        AddFacultyField(
          label: 'Employee ID',
          isRequired: true,
          child: AddFacultyTextField(
            controller: employeeIdController,
            hintText: 'e.g. EMP-CS-041',
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.next,
            validator: employeeIdValidator,
          ),
        ),
        AddFacultyField(
          label: 'Department',
          child: AddFacultyDropdownField(
            value: department,
            items: AddFacultyOptions.departments,
            onChanged: onDepartmentChanged,
          ),
        ),
        AddFacultyField(
          label: 'Designation / Role',
          child: AddFacultyDropdownField(
            value: designation,
            items: AddFacultyOptions.designations,
            onChanged: onDesignationChanged,
          ),
        ),
        AddFacultyField(
          label: 'Institutional email',
          isRequired: true,
          child: AddFacultyTextField(
            controller: emailController,
            hintText: 'name@campus.edu',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: emailValidator,
          ),
        ),
        AddFacultyField(
          label: 'Contact number',
          child: AddFacultyTextField(
            controller: contactController,
            hintText: '+1 (555) 000-0000',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            validator: contactValidator,
          ),
        ),
        AddFacultyField(
          label: 'Status',
          child: AddFacultyDropdownField(
            value: isActive ? activeStatusLabel : inactiveStatusLabel,
            items: const [activeStatusLabel, inactiveStatusLabel],
            onChanged: (value) {
              if (value == null) return;

              onStatusChanged(value == activeStatusLabel);
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'add_faculty_dialog_actions.dart';
import 'add_faculty_form_fields.dart';
import 'add_faculty_options.dart';

class AddFacultyForm extends StatefulWidget {
  const AddFacultyForm({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  State<AddFacultyForm> createState() => _AddFacultyFormState();
}

class _AddFacultyFormState extends State<AddFacultyForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _employeeIdController = TextEditingController(text: 'EMP-CS-050');
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _rfidController = TextEditingController();

  String _department = AddFacultyOptions.departments.first;
  String _designation = AddFacultyOptions.designations[1];
  String _status = AddFacultyOptions.statuses.first;

  @override
  void dispose() {
    _fullNameController.dispose();
    _employeeIdController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _rfidController.dispose();
    super.dispose();
  }

  void _handleDepartmentChanged(String? value) {
    if (value == null) return;

    setState(() => _department = value);
  }

  void _handleDesignationChanged(String? value) {
    if (value == null) return;

    setState(() => _designation = value);
  }

  void _handleStatusChanged(String? value) {
    if (value == null) return;

    setState(() => _status = value);
  }

  void _handleCancel() {
    widget.onDismiss();
  }

  void _handleSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    widget.onDismiss();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required.';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return null;

    final emailPattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return emailPattern.hasMatch(email) ? null : 'Enter a valid email address.';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
            child: Form(
              key: _formKey,
              child: AddFacultyFormFields(
                fullNameController: _fullNameController,
                employeeIdController: _employeeIdController,
                emailController: _emailController,
                contactController: _contactController,
                rfidController: _rfidController,
                department: _department,
                designation: _designation,
                status: _status,
                onDepartmentChanged: _handleDepartmentChanged,
                onDesignationChanged: _handleDesignationChanged,
                onStatusChanged: _handleStatusChanged,
                fullNameValidator: _validateFullName,
                emailValidator: _validateEmail,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: AddFacultyDialogActions(
            onCancel: _handleCancel,
            onSave: _handleSave,
          ),
        ),
      ],
    );
  }
}

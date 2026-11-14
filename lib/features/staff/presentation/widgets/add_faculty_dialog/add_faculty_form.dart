import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/dependency_injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/staff_entity.dart';
import 'add_faculty_dialog_actions.dart';
import 'add_faculty_form_fields.dart';
import 'add_faculty_options.dart';

class AddFacultyForm extends ConsumerStatefulWidget {
  const AddFacultyForm({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  ConsumerState<AddFacultyForm> createState() => _AddFacultyFormState();
}

class _AddFacultyFormState extends ConsumerState<AddFacultyForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  String _department = AddFacultyOptions.departments.first;
  String _designation = AddFacultyOptions.designations[1];

  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _fullNameController.dispose();
    _employeeIdController.dispose();
    _emailController.dispose();
    _contactController.dispose();
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

  void _handleCancel() {
    widget.onDismiss();
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    final staff = StaffEntity(
      // The record id is assigned by the database, so this placeholder is
      // never included in the insert payload.
      id: 0,
      name: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      staffId: _employeeIdController.text.trim(),
      department: _department,
      position: _designation,
      phoneNo: _parsePhone(_contactController.text),
    );

    final container = ProviderScope.containerOf(context, listen: false);
    final result = await ref.read(createStaffUseCaseProvider)(staff);

    result.fold(
      (failure) {
        if (!mounted) return;

        setState(() {
          _isSaving = false;
          _errorMessage = failure.toString();
        });
      },
      (_) {
        container.invalidate(staffListProvider);

        if (mounted) {
          widget.onDismiss();
        }
      },
    );
  }

  int? _parsePhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) return null;

    return int.tryParse(digits);
  }

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required.';
    }

    return null;
  }

  String? _validateEmployeeId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Employee ID is required.';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Institutional email is required.';
    }

    final emailPattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return emailPattern.hasMatch(email) ? null : 'Enter a valid email address.';
  }

  String? _validateContact(String? value) {
    final contact = value?.trim() ?? '';

    if (contact.isEmpty) return null;

    final digits = contact.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7 || digits.length > 15) {
      return 'Enter a valid contact number.';
    }

    return null;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AddFacultyFormFields(
                    fullNameController: _fullNameController,
                    employeeIdController: _employeeIdController,
                    emailController: _emailController,
                    contactController: _contactController,
                    department: _department,
                    designation: _designation,
                    onDepartmentChanged: _handleDepartmentChanged,
                    onDesignationChanged: _handleDesignationChanged,
                    fullNameValidator: _validateFullName,
                    employeeIdValidator: _validateEmployeeId,
                    emailValidator: _validateEmail,
                    contactValidator: _validateContact,
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 14),
                    _SaveErrorMessage(message: _errorMessage!),
                  ],
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: AddFacultyDialogActions(
            onCancel: _handleCancel,
            onSave: _handleSave,
            isSaving: _isSaving,
          ),
        ),
      ],
    );
  }
}

class _SaveErrorMessage extends StatelessWidget {
  const _SaveErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.dangerSoft,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 14,
            color: AppColors.danger,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

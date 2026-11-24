import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/dependency_injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/staff_entity.dart';
import '../../../domain/usecases/create_staff_with_authorization_usecase.dart';
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
  static const _uuid = Uuid();

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _instituteIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  String _department = AddFacultyOptions.departments.first;
  String _designation = AddFacultyOptions.designations[1];
  bool _isActive = true;
  String _authorityLevel = 'staff';

  bool _isSaving = false;
  String? _errorMessage;

  String get _authorityLevelLabel =>
      _authorityLevel == 'admin' ? 'Admin' : 'Staff';

  @override
  void dispose() {
    _fullNameController.dispose();
    _employeeIdController.dispose();
    _instituteIdController.dispose();
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

  void _handleStatusChanged(bool value) {
    setState(() => _isActive = value);
  }

  void _handleAuthorityLevelChanged(String? value) {
    if (value == null) return;

    setState(() => _authorityLevel = value == 'Admin' ? 'admin' : 'staff');
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
      // Staff ids are generated client-side as UUID v7 values.
      id: _uuid.v7(),
      name: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      staffId: _employeeIdController.text.trim(),
      instituteId: _instituteIdController.text.trim(),
      department: _department,
      position: _designation,
      status: _isActive,
      phoneNo: _parsePhone(_contactController.text),
    );

    final staffController = ref.read(staffControllerProvider.notifier);
    final result = await ref.read(createStaffWithAuthorizationUseCaseProvider)(
      CreateStaffWithAuthorizationParams(
        staff: staff,
        authorityLevel: _authorityLevel,
      ),
    );

    result.fold(
      (failure) {
        if (!mounted) return;

        setState(() {
          _isSaving = false;
          _errorMessage = failure.toString();
        });
      },
      (_) {
        staffController.refreshStaff();

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

  String? _validateInstituteId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Institute ID is required.';
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
                    instituteIdController: _instituteIdController,
                    emailController: _emailController,
                    contactController: _contactController,
                    department: _department,
                    designation: _designation,
                    isActive: _isActive,
                    authorityLevel: _authorityLevelLabel,
                    onDepartmentChanged: _handleDepartmentChanged,
                    onDesignationChanged: _handleDesignationChanged,
                    onStatusChanged: _handleStatusChanged,
                    onAuthorityLevelChanged: _handleAuthorityLevelChanged,
                    fullNameValidator: _validateFullName,
                    employeeIdValidator: _validateEmployeeId,
                    instituteIdValidator: _validateInstituteId,
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

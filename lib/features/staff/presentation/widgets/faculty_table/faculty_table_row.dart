import 'package:flutter/material.dart';

import '../../../domain/entity/staff_entity.dart';
import '../../controller/staff_state.dart';
import 'faculty_contact_cell.dart';
import 'faculty_department_cell.dart';
import 'faculty_member_cell.dart';
import 'faculty_status_pill.dart';
import 'staff_actions_menu.dart';

class FacultyTableRow extends StatelessWidget {
  const FacultyTableRow({
    super.key,
    required this.member,
    required this.showContact,
    required this.showStatus,
  });

  final StaffEntity member;
  final bool showContact;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final isActive = member.status;

    return SizedBox(
      height: 66,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Expanded(flex: 3, child: FacultyMemberCell(member: member)),
            const SizedBox(width: 14),
            Expanded(flex: 3, child: FacultyDepartmentCell(member: member)),
            if (showContact) ...[
              const SizedBox(width: 14),
              Expanded(flex: 3, child: FacultyContactCell(member: member)),
            ],
            if (showStatus) ...[
              const SizedBox(width: 14),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FacultyStatusPill(
                    label: isActive ? activeStatusLabel : inactiveStatusLabel,
                    active: isActive,
                  ),
                ),
              ),
            ],
            SizedBox(
              width: 36,
              height: 36,
              child: StaffActionsMenu(member: member),
            ),
          ],
        ),
      ),
    );
  }
}

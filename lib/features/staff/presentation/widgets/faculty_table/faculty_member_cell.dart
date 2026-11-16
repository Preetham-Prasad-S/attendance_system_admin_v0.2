import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/staff_entity.dart';
import 'faculty_avatar.dart';

const _avatarPalette = <Color>[
  AppColors.avatarBlue,
  AppColors.avatarViolet,
  AppColors.avatarEmerald,
  AppColors.avatarOrange,
  AppColors.avatarPink,
];

String _initialsFor(String name) {
  final parts = name
      .replaceAll('.', '')
      .split(' ')
      .where((part) => part != 'Dr' && part != 'Prof' && part.isNotEmpty)
      .take(2);

  return parts.map((part) => part[0]).join().toUpperCase();
}

class FacultyMemberCell extends StatelessWidget {
  const FacultyMemberCell({super.key, required this.member});

  final StaffEntity member;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FacultyAvatar(
          label: _initialsFor(member.name),
          color: _avatarPalette[member.id.hashCode % _avatarPalette.length],
          statusColor: member.status ? AppColors.success : AppColors.muted,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                member.staffId,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

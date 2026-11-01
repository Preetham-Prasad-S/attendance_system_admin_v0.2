import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    this.width = 220,
    required this.selectedIndex,
    required this.onElementSelected,
  });

  final double width;
  final int selectedIndex;
  final ValueChanged<int> onElementSelected;

  static const _elements = <_SidebarElement>[
    _SidebarElement(icon: Icons.grid_view_rounded, label: 'Dashboard'),
    _SidebarElement(icon: Icons.groups_outlined, label: 'Students'),
    _SidebarElement(icon: Icons.badge_outlined, label: 'Faculty & Staff'),
    _SidebarElement(icon: Icons.calendar_today_outlined, label: 'Timetable'),
    _SidebarElement(icon: Icons.fingerprint_rounded, label: 'Attendance'),
    _SidebarElement(
      icon: Icons.event_note_outlined,
      label: 'Leave Requests',
      badge: '3',
    ),
    _SidebarElement(icon: Icons.insights_rounded, label: 'Analytics'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(right: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: _SidebarTitle(),
          ),
          const SizedBox(height: 28),
          for (var index = 0; index < _elements.length; index++)
            _SidebarTile(
              icon: _elements[index].icon,
              label: _elements[index].label,
              badge: _elements[index].badge,
              active: selectedIndex == index,
              onTap: () => onElementSelected(index),
            ),
        ],
      ),
    );
  }
}

class _SidebarElement {
  const _SidebarElement({required this.icon, required this.label, this.badge});

  final IconData icon;
  final String label;
  final String? badge;
}

class _SidebarTitle extends StatelessWidget {
  const _SidebarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Icon(
            Icons.school_rounded,
            color: AppColors.white,
            size: 17,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CampusPulse',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Smart Attendance OS',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.1,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary.withValues(alpha: 0.65),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    this.badge,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final foreground = active ? AppColors.primary : AppColors.muted;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Material(
        color: active ? AppColors.primarySoft : AppColors.transperant,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 36,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(icon, size: 16, color: foreground),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                        color: active ? AppColors.primary : AppColors.navy,
                      ),
                    ),
                  ),
                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'sidebar_tile.dart';
import 'sidebar_title.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    this.width = 250,
    required this.selectedIndex,
    required this.onElementSelected,
  });

  final double width;
  final int selectedIndex;
  final ValueChanged<int> onElementSelected;

  static const _elements = <_SidebarElement>[
    _SidebarElement(icon: Icons.grid_view_rounded, label: 'Dashboard'),
    _SidebarElement(icon: Icons.badge_outlined, label: 'Faculty & Staff'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SidebarTitle(),
            ),
            const SizedBox(height: 24),
            for (var index = 0; index < _elements.length; index++)
              SidebarTile(
                icon: _elements[index].icon,
                label: _elements[index].label,
                active: selectedIndex == index,
                onTap: () => onElementSelected(index),
              ),
          ],
        ),
      ),
    );
  }
}

class _SidebarElement {
  const _SidebarElement({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

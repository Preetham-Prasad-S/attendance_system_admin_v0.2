import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../staff/presentation/screens/staff_screen.dart';
import '../../../staff/presentation/widgets/app_sidebar.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 2;

  static const _pages = <Widget>[
    _EmptySectionPage(title: 'Dashboard', icon: Icons.grid_view_rounded),
    _EmptySectionPage(title: 'Students', icon: Icons.groups_outlined),
    StaffScreen(),
    _EmptySectionPage(title: 'Timetable', icon: Icons.calendar_today_outlined),
    _EmptySectionPage(title: 'Attendance', icon: Icons.fingerprint_rounded),
    _EmptySectionPage(title: 'Leave Requests', icon: Icons.event_note_outlined),
    _EmptySectionPage(title: 'Analytics', icon: Icons.insights_rounded),
  ];

  void _handleElementSelected(int index) {
    setState(() => _selectedIndex = index);

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.canvas,
      drawer: Drawer(
        width: 280,
        backgroundColor: AppColors.white,
        child: SafeArea(
          child: AppSidebar(
            width: 280,
            selectedIndex: _selectedIndex,
            onElementSelected: _handleElementSelected,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final showSidebar = constraints.maxWidth >= 720;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showSidebar)
                AppSidebar(
                  selectedIndex: _selectedIndex,
                  onElementSelected: _handleElementSelected,
                ),
              Expanded(
                child: IndexedStack(index: _selectedIndex, children: _pages),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptySectionPage extends StatelessWidget {
  const _EmptySectionPage({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.canvas,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 25, color: AppColors.primary),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'This section is coming soon.',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

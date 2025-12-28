import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For Material Colors if needed, or stick to Cupertino
import 'package:google_fonts/google_fonts.dart';
import '../components/responsive_layout.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'My Kanban Board',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(CupertinoIcons.add),
      ),
      child: ResponsiveLayout(
        mobileBody: const _MobileBoardView(),
        tabletBody: const _TabletBoardView(),
        desktopBody: const _DesktopBoardView(),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Dummy Data
// -----------------------------------------------------------------------------
final List<String> _dummyColumns = [
  'To Do',
  'In Progress',
  'Code Review',
  'Done',
  'Archive',
  'Backlog',
  'Ideas',
  'Sprint 1',
  'Sprint 2',
  'Sprint 3'
];

// -----------------------------------------------------------------------------
// 1. Mobile View (PageView - 1 Column per page)
// -----------------------------------------------------------------------------
class _MobileBoardView extends StatelessWidget {
  const _MobileBoardView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9), // Show a peek of next card
        itemCount: _dummyColumns.length,
        itemBuilder: (context, index) {
          return _ColumnItem(
            title: _dummyColumns[index],
            color: CupertinoColors.systemGrey6,
            isMobile: true,
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. Tablet View (ListView - 2~3 Columns visible)
// -----------------------------------------------------------------------------
class _TabletBoardView extends StatelessWidget {
  const _TabletBoardView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _dummyColumns.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 300, // Fixed width for tablet columns
            child: _ColumnItem(
              title: _dummyColumns[index],
              color: CupertinoColors.systemGroupedBackground,
              isMobile: false,
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. Desktop View (ListView - Wide, Max Contraints handled by Wrapper)
// -----------------------------------------------------------------------------
class _DesktopBoardView extends StatelessWidget {
  const _DesktopBoardView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _dummyColumns.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 350, // Slightly wider columns for desktop
            child: _ColumnItem(
              title: _dummyColumns[index],
              color: CupertinoColors.secondarySystemGroupedBackground,
              isMobile: false,
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Reusable Column Component
// -----------------------------------------------------------------------------
class _ColumnItem extends StatelessWidget {
  final String title;
  final Color color;
  final bool isMobile;

  const _ColumnItem({
    required this.title,
    required this.color,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 8.0 : 12.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Icon(
                  CupertinoIcons.ellipsis,
                  color: CupertinoColors.systemGrey,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: CupertinoColors.systemGrey5),
          
          // Cards List Area (Placeholder)
          Expanded(
            child: Center(
              child: Text(
                'Drop tasks here',
                style: GoogleFonts.inter(
                  color: CupertinoColors.systemGrey3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          // Add Button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CupertinoButton(
              onPressed: () {},
              color: CupertinoColors.tertiarySystemFill,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.add, size: 16, color: CupertinoColors.systemGrey),
                  const SizedBox(width: 8),
                  Text(
                    'Add Task',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../components/responsive_layout.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appColorProvider);

    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: colors.surface.withOpacity(0.8), // Glass effect
        middle: Text(
          'My Kanban Board',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: colors.text,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theme Toggle Button
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                colors.themeToggleIcon,
                color: colors.icon,
                size: 24,
              ),
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
            const SizedBox(width: 8),
            // Add Button
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.add, size: 28, color: colors.icon),
              onPressed: () {},
            ),
          ],
        ),
      ),
      child: ResponsiveLayout(
        mobileBody: _MobileBoardView(colors: colors),
        tabletBody: _TabletBoardView(colors: colors),
        desktopBody: _DesktopBoardView(colors: colors),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Dummy Data
// -----------------------------------------------------------------------------
final List<String> _dummyColumns = [
  'To Do',
  'Code Review',
  'In Progress',
  'Done',
  'Archive',
  'Backlog',
  'Ideas',
  'Sprint 1',
  'Sprint 2',
  'Sprint 3'
];

// -----------------------------------------------------------------------------
// 1. Mobile View (PageView)
// -----------------------------------------------------------------------------
class _MobileBoardView extends StatelessWidget {
  final AppColors colors;
  const _MobileBoardView({required this.colors});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: _dummyColumns.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.topCenter,
            child: _ColumnItem(
              title: _dummyColumns[index],
              colors: colors,
              isMobile: true,
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. Tablet View (ListView)
// -----------------------------------------------------------------------------
class _TabletBoardView extends StatelessWidget {
  final AppColors colors;
  const _TabletBoardView({required this.colors});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _dummyColumns.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 300,
            child: Align(
              alignment: Alignment.topCenter,
              child: _ColumnItem(
                title: _dummyColumns[index],
                colors: colors,
                isMobile: false,
              ),
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. Desktop View (ListView)
// -----------------------------------------------------------------------------
class _DesktopBoardView extends StatelessWidget {
  final AppColors colors;
  const _DesktopBoardView({required this.colors});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _dummyColumns.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 350,
            child: Align(
              alignment: Alignment.topCenter,
              child: _ColumnItem(
                title: _dummyColumns[index],
                colors: colors,
                isMobile: false,
              ),
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
  final bool isMobile;
  final AppColors colors;

  const _ColumnItem({
    required this.title,
    required this.isMobile,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 8.0 : 12.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        color: colors.columnBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content height
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
                    color: colors.text,
                  ),
                ),
                Icon(
                  CupertinoIcons.ellipsis,
                  color: colors.subText,
                ),
              ],
            ),
          ),
          Container(height: 1, color: colors.border),
          
          // Cards List Area (Placeholder with min height)
          Container(
            constraints: const BoxConstraints(minHeight: 100),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Drop tasks here',
                style: GoogleFonts.inter(
                  color: colors.cardPlaceholderText,
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
              color: colors.border, // Using border color (greyish) for subtle button or define separate
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(CupertinoIcons.add, size: 16, color: colors.subText),
                   const SizedBox(width: 8),
                  Text(
                    'Add Task',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: colors.subText,
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

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 1200;
  static const double maxContentWidth = 1920;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. Desktop (Wide Screen)
        if (constraints.maxWidth >= desktopBreakpoint) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContentWidth),
              child: desktopBody,
            ),
          );
        }
        
        // 2. Tablet / Foldable (Mid Size)
        else if (constraints.maxWidth >= mobileBreakpoint) {
          return tabletBody;
        }
        
        // 3. Mobile (Small Size)
        else {
          return mobileBody;
        }
      },
    );
  }
}

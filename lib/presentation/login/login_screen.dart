import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/providers/providers.dart';
import '../../core/theme/theme_provider.dart';
import 'auth_view_model.dart';
import 'dart:math' as math;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final username = _controller.text;
    ref.read(authViewModelProvider.notifier).login(username);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final colors = ref.watch(appColorProvider);

    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      child: Stack(
        children: [
          // 1. Animated Gradient Mesh
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                children: [
                   Positioned(
                    top: -100 + (math.sin(_animationController.value * 2 * math.pi) * 20),
                    right: -100 + (math.cos(_animationController.value * 2 * math.pi) * 20),
                    child: _GradientBlob(color: CupertinoColors.systemBlue.withOpacity(0.4)),
                  ),
                  Positioned(
                    bottom: -100 - (math.sin(_animationController.value * 2 * math.pi) * 20),
                    left: -100 - (math.cos(_animationController.value * 2 * math.pi) * 20),
                    child: _GradientBlob(color: CupertinoColors.systemPurple.withOpacity(0.4)),
                  ),
                ],
              );
            },
          ),
          
          // 2. Main Content Center
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: colors.surface.withOpacity(0.6), // Adaptable surface
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colors.border,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.shadow,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.square_list_fill,
                        size: 64,
                        color: colors.buttonBackground,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Hello, Stranger',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colors.text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What should we call you?',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: colors.subText,
                        ),
                      ),
                      const SizedBox(height: 32),
                      CupertinoTextField(
                        controller: _controller,
                        placeholder: 'Enter your name',
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: colors.inputBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.border),
                        ),
                        style: GoogleFonts.inter(color: colors.text),
                      ),
                      const SizedBox(height: 24),
                      if (authState.error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            authState.error!,
                            style: const TextStyle(color: CupertinoColors.destructiveRed),
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          onPressed: authState.isLoading ? null : _handleLogin,
                          borderRadius: BorderRadius.circular(12),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: colors.buttonText),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Theme Toggle Button
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    colors.themeToggleIcon,
                    size: 28,
                    color: colors.icon,
                  ),
                  onPressed: () {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),
              ),
            ),
          ),

          // 4. Loading Overlay
          if (authState.isLoading)
            Stack(
              children: [
                // Dimmed Background
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: CupertinoColors.black.withOpacity(0.3),
                    ),
                  ),
                ),
                // Loading Content
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CupertinoActivityIndicator(
                        radius: 20, 
                        color: CupertinoColors.white,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Creating your workspace...',
                        style: GoogleFonts.inter(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _GradientBlob extends StatelessWidget {
  final Color color;

  const _GradientBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

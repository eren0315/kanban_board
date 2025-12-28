import 'dart:ui'; // For BackdropFilter
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/providers/providers.dart';
import 'auth_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _controller = TextEditingController();

  void _handleLogin() {
    final username = _controller.text;
    ref.read(authViewModelProvider.notifier).login(username);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return CupertinoPageScaffold(
      // Gradient Background
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Stack(
        children: [
          // 1. Colorful Gradient Mesh (Simulated with Containers)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemBlue.withOpacity(0.4),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemPurple.withOpacity(0.4),
              ),
            ),
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
                    color: CupertinoColors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: CupertinoColors.white.withOpacity(0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo / Icon
                      const Icon(
                        CupertinoIcons.square_list_fill,
                        size: 64,
                        color: CupertinoColors.activeBlue,
                      ),
                      const SizedBox(height: 24),
                      
                      // Title
                      Text(
                        'Hello, Stranger',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What should we call you?',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Input Field
                      CupertinoTextField(
                        controller: _controller,
                        placeholder: 'Enter your name',
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: CupertinoColors.systemGrey5),
                        ),
                        style: GoogleFonts.inter(),
                      ),
                      const SizedBox(height: 24),

                      // Error Message
                      if (authState.error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            authState.error!,
                            style: const TextStyle(color: CupertinoColors.destructiveRed),
                          ),
                        ),

                      // Button
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          onPressed: authState.isLoading ? null : _handleLogin,
                          borderRadius: BorderRadius.circular(12),
                          child: authState.isLoading
                              ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                              : Text(
                                  'Get Started',
                                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

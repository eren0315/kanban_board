import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/theme_provider.dart';
import 'presentation/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load Environment Variables
    await dotenv.load(fileName: ".env");

    // Initialize Supabase
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
  } catch (e) {
    debugPrint('Initialization Error: $e');
  }

  runApp(
    const ProviderScope(
      child: KanbanApp(),
    ),
  );
}

class KanbanApp extends ConsumerWidget {
  const KanbanApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final brightness = ref.watch(themeProvider);

    return CupertinoApp.router(
      title: 'iOS Kanban Board',
      theme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: CupertinoColors.systemBlue,
        // Apply background color based on theme
        scaffoldBackgroundColor: brightness == Brightness.dark
            ? CupertinoColors.black
            : CupertinoColors.systemGroupedBackground,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

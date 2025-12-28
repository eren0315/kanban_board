import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    // Continue running app even if initialization fails, 
    // so we can show a friendly error screen instead of a black screen.
  }

  runApp(
    const ProviderScope(
      child: KanbanApp(),
    ),
  );
}

class KanbanApp extends StatelessWidget {
  const KanbanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'iOS Kanban Board',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// Basic GoRouter Setup
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Kanban Board'),
        ),
        child: Center(
          child: Text('Hexagonal Architecture Setup Complete'),
        ),
      ),
    ),
  ],
);

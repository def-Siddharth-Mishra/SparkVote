import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sparkvote/presentation/providers/idea_provider.dart';
import 'package:sparkvote/presentation/providers/theme_provider.dart';
import 'package:sparkvote/presentation/screens/home_screen.dart';

import 'data/datasources/local_storage_service.dart';
import 'data/repositories/idea_repository_impl.dart';
import 'domain/repositories/idea_repository.dart';

void main() {
  runApp(const StartupIdeaApp());
}

class StartupIdeaApp extends StatelessWidget {
  const StartupIdeaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // --- Data Layer Providers ---
        Provider<LocalStorageService>(create: (_) => LocalStorageService()),
        // The IdeaRepository implementation depends on LocalStorageService.
        // We use ProxyProvider to wire them together.
        ProxyProvider<LocalStorageService, IdeaRepository>(
          update: (context, localStorageService, previous) =>
              IdeaRepositoryImpl(localStorageService),
        ),

        // --- Presentation Layer (State Management) Providers ---
        ChangeNotifierProvider(
          create: (context) => ThemeProvider()..loadTheme(),
        ),
        // IdeaProvider depends on IdeaRepository.
        ChangeNotifierProxyProvider<IdeaRepository, IdeaProvider>(
          create: (context) => IdeaProvider(context.read<IdeaRepository>()),
          update: (context, ideaRepository, previous) =>
              IdeaProvider(ideaRepository),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Startup Idea Evaluator',
            themeMode: themeProvider.themeMode,
            theme: _buildTheme(Brightness.light),
            darkTheme: _buildTheme(Brightness.dark),
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
    );
  }
}

import 'package:check_list_demo/application/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:moon_design/moon_design.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    const lightTokens = MoonTokens.light;
    final lightTheme = ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: lightTokens)],
      scaffoldBackgroundColor: Color(0xFFF6F7F9),
      brightness: Brightness.dark
    );
    return MaterialApp.router(
      routerConfig: appRouters,
      theme: lightTheme,
      builder: (context, child){
        return KeyboardDismisser(child: child);
      },
    );
  }
}
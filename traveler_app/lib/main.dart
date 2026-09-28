import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'widgets/nav_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const SmartDzimbabweTravelerApp());
}

/// Traveler-facing Smart Dzimbabwe app.
///
/// Intentionally has NO login, signup, or account gate anywhere in this
/// tree — the very first frame the traveler sees is NavShell, which opens
/// on the Explore/listings tab. Anything requiring identity (operator
/// tools, admin tools) lives entirely in the separate `operator_app`.
class SmartDzimbabweTravelerApp extends StatelessWidget {
  const SmartDzimbabweTravelerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Dzimbabwe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const NavShell(),
    );
  }
}

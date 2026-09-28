import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/role_select_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const SmartDzimbabwePartnersApp());
}

/// Operator & admin-facing Smart Dzimbabwe app. Ships as a separate app
/// from the traveler app — this one requires an account. Opens on the
/// role picker, then routes to sign in / register.
class SmartDzimbabwePartnersApp extends StatelessWidget {
  const SmartDzimbabwePartnersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Dzimbabwe Partners',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RoleSelectScreen(),
    );
  }
}

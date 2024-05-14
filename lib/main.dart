import 'package:crossflow_mobile/theme/app_theme.dart';
import 'package:crossflow_mobile/auth/auth_page.dart';
import 'package:crossflow_mobile/firebase_options.dart';
import 'package:crossflow_mobile/pages/auth-pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(GetMaterialApp(
    theme: AppTheme.darkMode,
    debugShowCheckedModeBanner: false,
    home: AuthPage()));
}



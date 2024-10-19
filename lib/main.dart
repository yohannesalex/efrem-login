import 'package:ef/features/authentication/data/resource/domain/entity/login_entity.dart';
import 'package:ef/features/authentication/data/resource/domain/repositories/auth_repository.dart';
import 'package:ef/features/authentication/data/resource/domain/usecases/login_usecase.dart';
import 'package:ef/features/authentication/presentation/widget/email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/authentication/presentation/pages/login.dart';
import 'features/authentication/presentation/provider/auth_provider.dart';
import 'features/authentication/presentation/provider/theme_provider.dart';
// Your main app widget

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        // Add other providers here if necessary
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      title: 'Aladia Exercise',
      home: const LoginPage(),
    );
  }
}

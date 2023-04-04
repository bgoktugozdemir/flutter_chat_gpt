import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants.dart';
import 'package:flutter_chat_gpt/core/presentation/app_colors.dart';
import 'package:flutter_chat_gpt/features/chat/presentation/chat_page.dart';

void main() {
  assert(Constants.apiToken.isNotEmpty, 'Please provide an API token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.buttonColor,
        ),
      ),
      home: const ChatPage(),
    );
  }
}

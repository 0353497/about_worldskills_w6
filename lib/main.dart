import 'package:about_worldskills/pages/welcome_page.dart';
import 'package:about_worldskills/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put<PageProvider>(PageProvider());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "Frutiger"),
      home: const WelcomePage(),
    );
  }
}

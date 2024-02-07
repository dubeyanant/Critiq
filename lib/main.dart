import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/screens/home.dart';
import 'package:critiq/controllers/mode_controller.dart';

var kBookLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.lightBlue,
);

var kMovieLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.red,
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ModeController mc = Get.put(ModeController());

    return Obx(
      () => GetMaterialApp(
        title: 'Critiq',
        theme: ThemeData(
          colorScheme: mc.switchBool.value
              ? kMovieLightColorScheme
              : kBookLightColorScheme,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

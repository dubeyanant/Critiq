import 'package:flutter/material.dart';

import 'package:get/get.dart';

var kBookLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.lightBlue,
);

var kMovieLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.red,
);

class ModeController extends GetxController {
  Rx<ColorScheme> mode = kBookLightColorScheme.obs;
  Rx<bool> switchBool = false.obs;
}

final ModeController mc = Get.put(ModeController());

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        title: 'Critiq',
        theme: ThemeData(
          colorScheme: mc.mode.value,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.movie);
        }
        return const Icon(
          Icons.book,
          color: Colors.black,
        );
      },
    );
    final MaterialStateProperty<Color?> outlineColor =
        MaterialStateProperty.resolveWith<Color?>(
      (final Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return null;
        }

        return Colors.blue;
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Critiq'),
        actions: <Widget>[
          Obx(
            () => Switch(
              thumbIcon: thumbIcon,
              inactiveTrackColor: Colors.blue,
              inactiveThumbColor: Colors.white,
              value: mc.switchBool.value,
              trackOutlineColor: outlineColor,
              onChanged: (bool value) {
                if (value) {
                  mc.mode.value = kMovieLightColorScheme;
                  mc.switchBool.value = true;
                } else {
                  mc.mode.value = kBookLightColorScheme;
                  mc.switchBool.value = false;
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to Critiq!',
        ),
      ),
    );
  }
}

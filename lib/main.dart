import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:critiq/screens/home.dart';
import 'package:critiq/controllers/mode_controller.dart';
import 'package:critiq/database/db_helper.dart';

var kBookLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.lightBlue,
);

var kMovieLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.red,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await GetStorage.init();
  await DBHelper().database;

  await dotenv.load(fileName: ".env");

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(const MyApp());
}

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

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class ModeController extends GetxController {
  Rx<bool> switchBool = (prefs.getBool('storedMode') ?? true).obs;
}

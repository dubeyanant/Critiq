import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import 'package:critiq/database/db_helper.dart';

class DBBackup {
  dbExportToDownloadFolder() async {
    File result = await DBHelper().dbExport();
    debugPrint("lllllllllllllllllll ${result.absolute.path}");

    Directory documentsDirectory = Directory("storage/emulated/0/Download/");

    String newPath = join('${documentsDirectory.absolute.path}critiqBackup.db');

    File b = File("${result.path}/items.db");

    requestPermission()
        .then((value) => b.copy(newPath))
        // ignore: invalid_return_type_for_catch_error
        .catchError((err) => debugPrint('Err: $err'))
        .then((value) {
      Get.snackbar(
        'Data backup',
        'successful!',
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[300],
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      );
      debugPrint('Backup successful: $value');
    });
  }

  importDataBaseFile() async {
    File dbPath = await DBHelper().dbExport();

    bool? clear = await FilePicker.platform.clearTemporaryFiles();
    debugPrint(clear.toString());

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    String recoveryPath = "${dbPath.path}/items.db";
    String newPath = "${result!.files.single.path}";

    File backupFile = File(newPath);
    backupFile.copy(recoveryPath);

    Get.snackbar(
      'Data import',
      'successful!',
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[300],
      margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
    );
  }

  Future<void> requestPermission() async {
    if (await Permission.accessMediaLocation.isDenied ||
        await Permission.storage.isDenied ||
        await Permission.manageExternalStorage.isDenied) {
      await Permission.accessMediaLocation.request();
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }
  }
}

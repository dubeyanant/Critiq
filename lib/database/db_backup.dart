import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import 'package:critiq/database/db_helper.dart';

class DBBackup {
  String exportBackupFileName =
      'backup__${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}__${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}.ctq';

  dbExportToDownloadFolder() async {
    File result = await DBHelper().dbExport();
    debugPrint("lllllllllllllllllll ${result.absolute.path}");

    Directory documentsDirectory = Directory("storage/emulated/0/Download/");

    String newPath =
        join('${documentsDirectory.absolute.path}$exportBackupFileName');

    File b = File("${result.path}/${DBHelper.databaseName}");

    requestPermission()
        .then((value) => b.copy(newPath))
        // ignore: invalid_return_type_for_catch_error
        .catchError((err) => debugPrint('Err: $err'))
        .then((value) {
      Get.snackbar(
        'Data backup successful!',
        '$exportBackupFileName file saved in Downloads folder.',
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

    await FilePicker.platform.clearTemporaryFiles();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    String? backupFileName = result?.names[0].toString();
    RegExp regex = RegExp(r'\.ctq$');

    if (backupFileName == null) {
      Get.snackbar('Data import', 'aborted!',
          dismissDirection: DismissDirection.horizontal,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[300],
          margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8));
    } else if (regex.hasMatch(backupFileName)) {
      String recoveryPath = "${dbPath.path}/${DBHelper.databaseName}";
      String newPath = "${result!.files.single.path}";

      File backupFile = File(newPath);
      backupFile.copy(recoveryPath);

      Get.snackbar(
        'Data import',
        'success!',
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[300],
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      );
    } else {
      Get.snackbar(
        'Data import',
        'failed!',
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[300],
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      );
    }
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

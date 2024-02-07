import 'package:get/get.dart';

import 'package:critiq/database/db_helper.dart';
import 'package:critiq/models/item.dart';

class ItemController extends GetxController {
  RxList itemList = <Item>[].obs;

  Future<void> getTask() async {
    final List<Map<String, dynamic>> items = await DBHelper().queryAllRows();
    itemList.assignAll(items.map((data) => Item.fromMap(data)).toList());
  }

  addTask(Item task) async {
    await DBHelper().insertItem(task);
    itemList.add(task);
    getTask();
  }

  deleteTask(int? id) async {
    await DBHelper().delete(id!);
    getTask();
  }
}

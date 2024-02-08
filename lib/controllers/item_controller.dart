import 'package:get/get.dart';

import 'package:critiq/database/db_helper.dart';
import 'package:critiq/models/item.dart';

class ItemController extends GetxController {
  RxList itemList = <Item>[].obs;

  Future<void> getItem() async {
    final List<Map<String, dynamic>> items = await DBHelper().queryAllRows();
    itemList.assignAll(items.map((data) => Item.fromMap(data)).toList());
  }

  addItem(Item item) async {
    await DBHelper().insertItem(item);
    itemList.add(item);
    getItem();
  }

  updateFavourite(int? id, bool? isFavourite) async {
    await DBHelper().updateFavourites(id!, isFavourite!.toString());
    getItem();
  }

  deleteItem(int? id) async {
    await DBHelper().delete(id!);
    getItem();
  }

  deleteCategory(String type) async {
    await DBHelper().deleteCategory(type);
    getItem();
  }

  deleteAllItems() async {
    await DBHelper().deleteAllItem();
    getItem();
  }

  dropDatabase() async {
    await DBHelper().dropTableAndDatabase();
  }
}

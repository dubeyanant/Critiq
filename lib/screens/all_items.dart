import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/controllers/mode_controller.dart';
import 'package:critiq/controllers/item_controller.dart';

class AllItemsScreen extends StatelessWidget {
  const AllItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModeController mc = Get.put(ModeController());
    final ItemController ic = Get.put(ItemController());
    ic.getItem();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          mc.switchBool.value ? 'All Movies' : 'All Books',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Get.snackbar(
                'All Data',
                'deleted successfully',
                dismissDirection: DismissDirection.horizontal,
              );
              ic.deleteCategory(mc.switchBool.toString());
            },
            tooltip: 'Delete All Items',
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => ic.itemList[index].type ==
                  mc.switchBool.value
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ic.itemList[index].title.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        ic.itemList[index].rating.toString(),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, size: 20),
                    ],
                  ),
                )
              : const SizedBox(),
          itemCount: ic.itemList.length,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

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
          TextButton.icon(
            onPressed: () {
              Get.snackbar(
                mc.switchBool.value ? 'All Movies Data' : 'All Books Data',
                'deleted successfully!',
                dismissDirection: DismissDirection.horizontal,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              );
              ic.deleteCategory(mc.switchBool.toString());
            },
            icon: const Icon(Icons.delete_forever),
            label: Text(
              mc.switchBool.value ? 'Delete\nAll Movies' : 'Delete\nAll Books',
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => ic.itemList[index].type ==
                  mc.switchBool.value
              ? Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(8),
                          onPressed: ((context) =>
                              ic.deleteItem(ic.itemList[index].id)),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        Obx(
                          () => SlidableAction(
                            borderRadius: BorderRadius.circular(8),
                            onPressed: ((context) {
                              if (ic.itemList[index].isFavourite) {
                                ic.itemList[index].isFavourite = false;
                              } else {
                                ic.itemList[index].isFavourite = true;
                              }
                              ic.updateFavourite(
                                ic.itemList[index].id,
                                ic.itemList[index].isFavourite,
                              );
                            }),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: ic.itemList[index].isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                        ),
                        SlidableAction(
                          borderRadius: BorderRadius.circular(8),
                          onPressed: ((context) {
                            String readWatch =
                                mc.switchBool.value ? 'watched' : 'read';
                            String emoji = mc.switchBool.value ? '🎬' : '📚';
                            String type = mc.switchBool.value
                                ? "Re-watchability: ${(ic.itemList[index].rewatchabilityRating + 1).toString()}⭐"
                                : "Character: ${(ic.itemList[index].characterRating + 1).toString()}⭐";
                            Share.share(
                                'Hello everyone👋\n\nI recently $readWatch ${ic.itemList[index].title.toString()}$emoji and here is my rating:\n\nInitial response: ${(ic.itemList[index].initialResponseRating + 1).toString()}⭐\nRecommendation: ${(ic.itemList[index].recommendationRating + 1).toString()}⭐\n$type\nPlot: ${(ic.itemList[index].plotRating + 1).toString()}⭐\nEnding: ${(ic.itemList[index].endingRating + 1).toString()}⭐\n\nOverall rating: ${ic.itemList[index].rating.toString()}🌟\n\nShared from Critiq app');
                          }),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              ic.itemList[index].title.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            ic.itemList[index].rating.toString(),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, size: 20),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          itemCount: ic.itemList.length,
        ),
      ),
    );
  }
}

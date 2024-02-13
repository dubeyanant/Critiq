import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import 'package:critiq/controllers/item_controller.dart';
import 'package:critiq/controllers/mode_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModeController mc = Get.put(ModeController());
    final ItemController ic = Get.put(ItemController());
    ic.getItem();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          mc.switchBool.value ? 'Favourite Movies' : 'Favourite Books',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              ic.deleteFavourite(mc.switchBool.toString(), true);
            },
            tooltip: 'Delete All Favourites',
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => ic.itemList[index].type ==
                      mc.switchBool.value &&
                  ic.itemList[index].isFavourite == true
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
                          Text(
                            ic.itemList[index].title.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
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

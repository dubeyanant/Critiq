import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/models/item.dart';
import 'package:critiq/controllers/item_controller.dart';
import 'package:critiq/controllers/mode_controller.dart';

final ItemController ic = Get.put(ItemController());
final ModeController mc = Get.put(ModeController());

class SliderController extends GetxController {
  Rx<String> itemTitle = "".obs;
  Rx<double> initialResponseScale = 0.0.obs;
  Rx<double> recommendationScale = 0.0.obs;
  Rx<double> rewatchabilityScale = 0.0.obs;
  Rx<double> plotScale = 0.0.obs;
  Rx<double> characterScale = 0.0.obs;
  Rx<double> endingScale = 0.0.obs;
  Rx<double> rating = 0.5.obs;

  /// Below function is used to calculate the rating of the book or movie
  void calculateRating() async {
    rating.value = (initialResponseScale.value +
            recommendationScale.value +
            rewatchabilityScale.value +
            plotScale.value +
            characterScale.value +
            endingScale.value +
            5) /
        10;

    /// Below function is used for rounding the rating value to nearest .5
    rating.value = ((rating.value * 2).round() / 2);

    /// Adding the item to the database
    final Item item = Item(
      title: itemTitle.value,
      initialResponseRating: initialResponseScale.value,
      recommendationRating: recommendationScale.value,
      rewatchabilityRating: rewatchabilityScale.value,
      plotRating: plotScale.value,
      characterRating: characterScale.value,
      endingRating: endingScale.value,
      rating: rating.value,
      type: mc.switchBool.value,
    );

    try {
      await ic.addItem(item);
      debugPrint("Item added to database");
    } catch (e) {
      debugPrint("Error adding item to database: $e");
    }
  }
}

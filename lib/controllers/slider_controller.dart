import 'package:get/get.dart';

class SliderController extends GetxController {
  Rx<double> initialResponseScale = 0.0.obs;
  Rx<double> recommendationScale = 0.0.obs;
  Rx<double> rewatchabilityScale = 0.0.obs;
  Rx<double> plotScale = 0.0.obs;
  Rx<double> characterScale = 0.0.obs;
  Rx<double> endingScale = 0.0.obs;
  Rx<double> rating = 0.5.obs;

  void calculateRating() {
    rating.value = (initialResponseScale.value +
            recommendationScale.value +
            rewatchabilityScale.value +
            plotScale.value +
            characterScale.value +
            endingScale.value +
            5) /
        10;

/**
 * Below function is used for rounding the rating value to nearest .5
 */
    rating.value = ((rating.value * 2).round() / 2);
  }
}

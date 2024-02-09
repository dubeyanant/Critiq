import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:critiq/controllers/add_item_view_controller.dart';
import 'package:critiq/controllers/mode_controller.dart';
import 'package:critiq/controllers/slider_controller.dart';
import 'package:critiq/widgets/add_item_widgets/final_rating.dart';
import 'package:critiq/widgets/add_item_widgets/find_items.dart';
import 'package:critiq/widgets/add_item_widgets/rate_item.dart';

final AddItemViewController aivc = Get.put(AddItemViewController());
final SliderController sc = Get.put(SliderController());

class AddItemsScreen extends StatelessWidget {
  const AddItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModeController mc = Get.put(ModeController());

    final Map<int, Widget> sequence = {
      0: const FindItems(),
      1: const RateInitialResponse(),
      2: const RateRecommendation(),
      3: mc.switchBool.value
          ? const RateRewatchability()
          : const RateCharacter(),
      4: const RatePlot(),
      5: const RateEnding(),
      6: const FinalRating(),
    };

    final List<String> addItemScreenTitle = [
      'Find Your Book',
      'Rate Initial Response',
      'Rate Your Recommendation',
      mc.switchBool.value ? 'Rate Rewatchability' : 'Rate Character',
      'Rate Plot',
      'Rate Ending',
      'Your Rating',
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(
            () => Column(
              children: [
                const SizedBox(height: 32),
                Text(
                  addItemScreenTitle[aivc.sequenceCount.value],
                  style: GoogleFonts.getFont('Pacifico').copyWith(fontSize: 24),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: sequence[aivc.sequenceCount]!,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    aivc.sequenceCount.value == 0
                        ? OutlinedButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              if (aivc.sequenceCount > 0) {
                                aivc.sequenceCount--;
                              } else {
                                Get.back();
                              }
                            },
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 24)),
                                iconSize: MaterialStatePropertyAll(36)),
                            label: Text(
                              'Back',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 20),
                            ),
                          )
                        : const SizedBox(),
                    aivc.sequenceCount.value < addItemScreenTitle.length - 1 &&
                            aivc.sequenceCount.value != 0
                        ? IconButton.outlined(
                            padding: const EdgeInsets.all(12),
                            iconSize: 36,
                            onPressed: () {
                              aivc.sequenceCount--;
                            },
                            icon: const Icon(Icons.arrow_back),
                          )
                        : const SizedBox(),
                    aivc.sequenceCount.value > 0 &&
                            aivc.sequenceCount.value <
                                addItemScreenTitle.length - 1
                        ? const SizedBox(width: 40)
                        : const SizedBox(),
                    aivc.sequenceCount.value > 0 &&
                            aivc.sequenceCount.value <
                                addItemScreenTitle.length - 2
                        ? IconButton.filled(
                            padding: const EdgeInsets.all(12),
                            iconSize: 36,
                            onPressed: () {
                              aivc.sequenceCount++;
                            },
                            icon: const Icon(Icons.arrow_forward),
                          )
                        : const SizedBox(),
                    aivc.sequenceCount.value == addItemScreenTitle.length - 2
                        ? FilledButton.icon(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              aivc.sequenceCount++;
                              sc.calculateRating();
                            },
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 24)),
                                iconSize: MaterialStatePropertyAll(36)),
                            label: Text(
                              'Calculate',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),
                    aivc.sequenceCount.value == addItemScreenTitle.length - 1
                        ? FilledButton.icon(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              Get.back();
                              aivc.sequenceCount.value = 0;
                            },
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 24)),
                                iconSize: MaterialStatePropertyAll(36)),
                            label: Text(
                              'Done',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

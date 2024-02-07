import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/screens/home.dart';

class SliderController extends GetxController {
  Rx<double> initialResponseScale = (0.0).obs;
  Rx<double> recommendationScale = (0.0).obs;
  Rx<double> rewatchabilityScale = (0.0).obs;
  Rx<double> plotScale = (0.0).obs;
  Rx<double> characterScale = (0.0).obs;
  Rx<double> endingScale = (0.0).obs;
}

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModeController mc = Get.put(ModeController());
    final SliderController sc = Get.put(SliderController());

    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Initial Response',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: sc.initialResponseScale.value,
                  inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                  max: 9,
                  divisions: 10,
                  label: (sc.initialResponseScale.value.round() + 1).toString(),
                  onChanged: (double value) {
                    sc.initialResponseScale.value = value;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Recommendation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: sc.recommendationScale.value,
                  inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                  max: 9,
                  divisions: 10,
                  label: (sc.recommendationScale.value.round() + 1).toString(),
                  onChanged: (double value) {
                    sc.recommendationScale.value = value;
                  },
                ),
                const SizedBox(height: 16),
                mc.switchBool.value
                    ? Text(
                        'Rewatchability',
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    : const SizedBox(),
                mc.switchBool.value
                    ? Slider(
                        value: sc.rewatchabilityScale.value,
                        inactiveColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        max: 9,
                        divisions: 10,
                        label: (sc.rewatchabilityScale.value.round() + 1)
                            .toString(),
                        onChanged: (double value) {
                          sc.rewatchabilityScale.value = value;
                        },
                      )
                    : const SizedBox(),
                mc.switchBool.value
                    ? const SizedBox(height: 16)
                    : const SizedBox(),
                mc.switchBool.value
                    ? const SizedBox()
                    : Text(
                        'Character',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                mc.switchBool.value
                    ? const SizedBox()
                    : Slider(
                        value: sc.characterScale.value,
                        inactiveColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        max: 9,
                        divisions: 10,
                        label: (sc.characterScale.value.round() + 1).toString(),
                        onChanged: (double value) {
                          sc.characterScale.value = value;
                        },
                      ),
                mc.switchBool.value
                    ? const SizedBox()
                    : const SizedBox(height: 16),
                Text(
                  'Plot',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: sc.plotScale.value,
                  max: 9,
                  inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                  divisions: 10,
                  label: (sc.plotScale.value.round() + 1).toString(),
                  onChanged: (double value) {
                    sc.plotScale.value = value;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Ending',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: sc.endingScale.value,
                  inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                  max: 9,
                  divisions: 10,
                  label: (sc.endingScale.value.round() + 1).toString(),
                  onChanged: (double value) {
                    sc.endingScale.value = value;
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

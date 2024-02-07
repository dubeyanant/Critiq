import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/controllers/slider_controller.dart';
import 'package:critiq/controllers/mode_controller.dart';

final ModeController mc = Get.find();

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 56),
                TextField(
                  onChanged: (String value) {
                    sc.itemTitle.value = value;
                  },
                  decoration: InputDecoration(
                    labelText: mc.switchBool.value
                        ? 'Enter Movie Title'
                        : 'Enter Book Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const SliderGroup(),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    ),
                    const SizedBox(width: 48),
                    ElevatedButton.icon(
                      onPressed: sc.calculateRating,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calculate'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  mc.switchBool.value
                      ? 'This movie rating is:'
                      : 'This book rating is:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Obx(
                  () => Text(
                    '${sc.rating}/5',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 48),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliderGroup extends StatelessWidget {
  const SliderGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Initial Response',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Slider(
            value: sc.initialResponseScale.value,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            max: 9,
            divisions: 9,
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
            divisions: 9,
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
                  inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                  max: 9,
                  divisions: 9,
                  label: (sc.rewatchabilityScale.value.round() + 1).toString(),
                  onChanged: (double value) {
                    sc.rewatchabilityScale.value = value;
                  },
                )
              : const SizedBox(),
          mc.switchBool.value ? const SizedBox(height: 16) : const SizedBox(),
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
                  inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                  max: 9,
                  divisions: 9,
                  label: (sc.characterScale.value.round() + 1).toString(),
                  onChanged: (double value) {
                    sc.characterScale.value = value;
                  },
                ),
          mc.switchBool.value ? const SizedBox() : const SizedBox(height: 16),
          Text(
            'Plot',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Slider(
            value: sc.plotScale.value,
            max: 9,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            divisions: 9,
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
            divisions: 9,
            label: (sc.endingScale.value.round() + 1).toString(),
            onChanged: (double value) {
              sc.endingScale.value = value;
            },
          ),
        ],
      ),
    );
  }
}

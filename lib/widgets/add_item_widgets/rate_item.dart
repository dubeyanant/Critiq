import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/controllers/mode_controller.dart';
import 'package:critiq/controllers/slider_controller.dart';

class RateInitialResponse extends StatelessWidget {
  const RateInitialResponse({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());
    final ModeController mc = Get.put(ModeController());

    final initialResponseSubHeadingScale = [
      "Very negative",
      "Somewhat negative",
      "Indifferent",
      "Somewhat positive",
      "Very positive",
    ];

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            mc.switchBool.value
                ? 'What was your initial response after finishing this movie?'
                : 'What was your initial response after finishing this book?',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Text(
            (sc.initialResponseScale.value.toInt() + 1).toString(),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 72),
          ),
          const SizedBox(height: 16),
          Slider(
            value: sc.initialResponseScale.value,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            max: 4,
            divisions: 4,
            label: (sc.initialResponseScale.value.round() + 1).toString(),
            onChanged: (double value) {
              sc.initialResponseScale.value = value;
            },
          ),
          Text(
            initialResponseSubHeadingScale[
                sc.initialResponseScale.value.toInt()],
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RateRecommendation extends StatelessWidget {
  const RateRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());

    final recommendationSubHeadingScale = [
      "Highly discourage",
      "Discourage",
      "Neutral",
      "Encourage",
      "Highly encourage",
    ];

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            mc.switchBool.value
                ? 'How likely are you to recommend this movie to a friend?'
                : 'How likely are you to recommend this book to a friend?',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Text(
            (sc.recommendationScale.value.toInt() + 1).toString(),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 72),
          ),
          const SizedBox(height: 16),
          Slider(
            value: sc.recommendationScale.value,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            max: 4,
            divisions: 4,
            label: (sc.recommendationScale.value.round() + 1).toString(),
            onChanged: (double value) {
              sc.recommendationScale.value = value;
            },
          ),
          Text(
            recommendationSubHeadingScale[sc.recommendationScale.value.toInt()],
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RateRewatchability extends StatelessWidget {
  const RateRewatchability({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());

    final rewatchabilitySubHeadingScale = [
      "Definitely not going through it again",
      "Unlikely to go through it again",
      "Neutral",
      "Likely to go through it again",
      "Definitely will go through it again",
    ];

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Would you consider re-watching this movie in the future?',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Text(
            (sc.rewatchabilityScale.value.toInt() + 1).toString(),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 72),
          ),
          const SizedBox(height: 16),
          Slider(
            value: sc.rewatchabilityScale.value,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            max: 4,
            divisions: 4,
            label: (sc.rewatchabilityScale.value.round() + 1).toString(),
            onChanged: (double value) {
              sc.rewatchabilityScale.value = value;
            },
          ),
          Text(
            rewatchabilitySubHeadingScale[sc.rewatchabilityScale.value.toInt()],
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RatePlot extends StatelessWidget {
  const RatePlot({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());

    final plotSubHeadingScale = [
      "Not engaged at all",
      "Somewhat engaged",
      "Moderately engaged",
      "Very engaged",
      "Extremely engaged",
    ];

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            mc.switchBool.value
                ? 'How engaging did you find the storyline of this movie?'
                : 'How engaging did you find the storyline of this book?',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Text(
            (sc.plotScale.value.toInt() + 1).toString(),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 72),
          ),
          const SizedBox(height: 16),
          Slider(
            value: sc.plotScale.value,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            max: 4,
            divisions: 4,
            label: (sc.plotScale.value.round() + 1).toString(),
            onChanged: (double value) {
              sc.plotScale.value = value;
            },
          ),
          Text(
            plotSubHeadingScale[sc.plotScale.value.toInt()],
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RateCharacter extends StatelessWidget {
  const RateCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());

    final characterSubHeadingScale = [
      "Uninteresting",
      "Slightly interesting",
      "Moderately interesting",
      "interesting",
      "Very interesting",
    ];

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'How interesting were the characters\nin this book?',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Text(
            (sc.characterScale.value.toInt() + 1).toString(),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 72),
          ),
          const SizedBox(height: 16),
          Slider(
            value: sc.characterScale.value,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            max: 4,
            divisions: 4,
            label: (sc.characterScale.value.round() + 1).toString(),
            onChanged: (double value) {
              sc.characterScale.value = value;
            },
          ),
          Text(
            characterSubHeadingScale[sc.characterScale.value.toInt()],
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RateEnding extends StatelessWidget {
  const RateEnding({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sc = Get.put(SliderController());

    final endingSubHeadingScale = [
      "Worst",
      "Bad",
      "Neutral",
      "Good",
      "Awesome",
    ];

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            mc.switchBool.value
                ? 'How satisfying did you find the ending to this movie?'
                : 'How satisfying did you find the ending to this book?',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Text(
            (sc.endingScale.value.toInt() + 1).toString(),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 72),
          ),
          const SizedBox(height: 16),
          Slider(
            value: sc.endingScale.value,
            inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            max: 4,
            divisions: 4,
            label: (sc.endingScale.value.round() + 1).toString(),
            onChanged: (double value) {
              sc.endingScale.value = value;
            },
          ),
          Text(
            endingSubHeadingScale[sc.endingScale.value.toInt()],
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

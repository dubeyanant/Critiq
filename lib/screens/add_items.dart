import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:critiq/controllers/add_item_view_controller.dart';
import 'package:critiq/widgets/add_item_widgets/find_items.dart';
import 'package:critiq/widgets/add_item_widgets/rate_item.dart';

final AddItemViewController aivc = Get.put(AddItemViewController());

class AddItemsScreen extends StatelessWidget {
  const AddItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> sequence = {
      1: const FindItems(),
      2: const RateItem(),
    };

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
                  'Find Your Book',
                  style: GoogleFonts.getFont('Pacifico').copyWith(fontSize: 24),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: sequence[aivc.sequenceCount]!,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.outlined(
                      padding: const EdgeInsets.all(12),
                      iconSize: 36,
                      onPressed: () {
                        if (aivc.sequenceCount > 1) {
                          aivc.sequenceCount--;
                        } else {
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    aivc.sequenceCount.value > 1
                        ? const SizedBox(width: 40)
                        : const SizedBox(),
                    aivc.sequenceCount.value > 1
                        ? IconButton.filled(
                            padding: const EdgeInsets.all(12),
                            iconSize: 36,
                            onPressed: () {
                              aivc.sequenceCount++;
                            },
                            icon: const Icon(Icons.arrow_forward),
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

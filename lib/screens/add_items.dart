import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:critiq/screens/add_item_widgets/find_items.dart';

class AddItemsScreen extends StatelessWidget {
  const AddItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Text(
                'Find Your Book',
                style: GoogleFonts.getFont('Pacifico').copyWith(fontSize: 24),
              ),
              const SizedBox(height: 32),
              const Expanded(
                // height: 550,

                child: FindItems(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    padding: const EdgeInsets.all(12),
                    iconSize: 36,
                    onPressed: Get.back,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  // const SizedBox(width: 40),
                  // IconButton.filled(
                  //   padding: const EdgeInsets.all(12),
                  //   iconSize: 36,
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.arrow_forward),
                  // ),
                ],
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

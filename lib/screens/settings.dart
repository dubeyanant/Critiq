import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:critiq/controllers/item_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController ic = Get.put(ItemController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 126, 125, 161),
        title: Text(
          'Settings',
          style: GoogleFonts.getFont('Pacifico'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Default Mode',
                  style: TextStyle(fontSize: 16),
                ),
                SubmenuButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    shadowColor: const MaterialStatePropertyAll(Colors.black),
                    elevation: const MaterialStatePropertyAll(4),
                    backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 231, 214, 246),
                    ),
                  ),
                  menuStyle: const MenuStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(231, 214, 246, 1)),
                  ),
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {},
                      child: const MenuAcceleratorLabel('Movies'),
                    ),
                    MenuItemButton(
                      onPressed: () {},
                      child: const MenuAcceleratorLabel('Books'),
                    ),
                  ],
                  child: const MenuAcceleratorLabel('Books'),
                )
              ],
            ),
            const SizedBox(height: 16),
            SubButton(
              buttonText: 'Backup Data',
              buttonColor: const Color.fromARGB(255, 231, 214, 246),
              buttonFunction: () {},
            ),
            const SizedBox(height: 16),
            SubButton(
              buttonText: 'Load Data',
              buttonColor: const Color.fromARGB(255, 231, 214, 246),
              buttonFunction: () {},
            ),
            const SizedBox(height: 16),
            SubButton(
              buttonText: 'Delete All Data',
              buttonColor: Theme.of(context).colorScheme.error,
              buttonFunction: () {
                Get.snackbar(
                  'All Data',
                  'deleted successfully!',
                  dismissDirection: DismissDirection.horizontal,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                );
                ic.deleteAllItems();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class SubButton extends StatelessWidget {
  const SubButton({
    super.key,
    required this.buttonColor,
    required this.buttonText,
    required this.buttonFunction,
  });

  final Color buttonColor;
  final String buttonText;
  final Function()? buttonFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonFunction,
      child: Container(
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: List.filled(
            4,
            const BoxShadow(
              color: Color.fromARGB(16, 0, 0, 0),
              offset: Offset(0, 3),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

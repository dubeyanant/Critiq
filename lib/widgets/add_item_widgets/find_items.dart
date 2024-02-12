import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

import 'package:critiq/controllers/mode_controller.dart';
import 'package:critiq/controllers/slider_controller.dart';
import 'package:critiq/controllers/api_controller.dart';
import 'package:critiq/screens/add_items.dart';

class FindItems extends StatelessWidget {
  const FindItems({super.key});

  @override
  Widget build(BuildContext context) {
    final APIController bc = Get.put(APIController());
    final SliderController sc = Get.put(SliderController());
    final ModeController mc = Get.put(ModeController());
    Timer? timer;

    return Column(
      children: [
        SearchBar(
          leading: const Icon(Icons.search),
          elevation: const MaterialStatePropertyAll(2),
          hintText:
              mc.switchBool.value ? 'Enter a movie name' : 'Enter a book name',
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          onChanged: (value) {
            if (timer?.isActive ?? false) timer!.cancel();
            timer = Timer(const Duration(seconds: 1), () {
              bc.itemName.value = value;
            });
          },
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Obx(() {
            return FutureBuilder(
              future: bc.fetchBooks(),
              builder: (context, snapshot) {
                if (bc.itemName.value == '') {
                  return Center(
                    child: Text(
                      mc.switchBool.value
                          ? 'Search for a movie,\nand tap on it to continue!'
                          : 'Search for a book,\nand tap on it to continue!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  debugPrint('Error: ${snapshot.error}');
                  return Center(
                    child: Text(
                      'Error occurred.\nSearch for another book.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                } else {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    children: bc.apiDataList
                        .where(
                            (data) => data['volumeInfo']['imageLinks'] != null)
                        .map(
                          (data) => InkWell(
                            onTap: () {
                              aivc.sequenceCount++;
                              sc.itemTitle.value =
                                  data['volumeInfo']['title'].toString();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.network(data['volumeInfo']
                                      ['imageLinks']['thumbnail']),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  data['volumeInfo']['title'].toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              },
            );
          }),
        ),
      ],
    );
  }
}

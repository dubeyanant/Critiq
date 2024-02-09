import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/screens/add_items.dart';

class FinalRating extends StatelessWidget {
  const FinalRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Text(
          '${sc.rating}/5',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 72),
        ),
      ),
    );
  }
}

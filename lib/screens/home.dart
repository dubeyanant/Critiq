import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:critiq/screens/favourite.dart';
import 'package:critiq/screens/all_items.dart';
import 'package:critiq/screens/add_item.dart';
import 'package:critiq/controllers/mode_controller.dart';
import 'package:critiq/controllers/books_api_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModeController mc = Get.put(ModeController());
    final BooksAPIController bc = Get.put(BooksAPIController());

    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.movie);
        }
        return const Icon(
          Icons.book,
          color: Colors.black,
        );
      },
    );

    final MaterialStateProperty<Color?> outlineColor =
        MaterialStateProperty.resolveWith<Color?>(
      (final Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return null;
        }

        return Colors.blue;
      },
    );

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Critiq', style: GoogleFonts.getFont('Pacifico')),
          actions: <Widget>[
            Switch(
              thumbIcon: thumbIcon,
              inactiveTrackColor: Colors.blue,
              inactiveThumbColor: Colors.white,
              value: mc.switchBool.value,
              trackOutlineColor: outlineColor,
              onChanged: (bool value) {
                if (value) {
                  mc.switchBool.value = true;
                } else {
                  mc.switchBool.value = false;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: bc.fetchBooks,
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            HomeItem(
              itemIcon: Icons.add_circle,
              itemTitle: mc.switchBool.value ? 'Rate a movie' : 'Rate a book',
              screenName: const AddItemScreen(),
            ),
            HomeItem(
              itemIcon: mc.switchBool.value
                  ? Icons.local_movies
                  : Icons.library_books,
              itemTitle: mc.switchBool.value ? 'All movies' : 'All books',
              screenName: const AllItemsScreen(),
            ),
            HomeItem(
              itemIcon: Icons.star,
              itemTitle:
                  mc.switchBool.value ? 'Favourite movies' : 'Favourite books',
              screenName: const FavouriteScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.itemIcon,
    required this.itemTitle,
    required this.screenName,
  });

  final Widget screenName;
  final IconData itemIcon;
  final String itemTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => screenName),
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.maxFinite,
        height: 64,
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Icon(itemIcon, size: 24),
            const SizedBox(width: 16),
            Text(
              itemTitle,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

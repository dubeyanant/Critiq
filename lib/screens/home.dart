import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:critiq/screens/add_items.dart';
import 'package:critiq/screens/favourite.dart';
import 'package:critiq/screens/all_items.dart';
import 'package:critiq/controllers/mode_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModeController mc = Get.put(ModeController());

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
            const IconButton(
              icon: Icon(Icons.settings),
              onPressed: null,
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => Get.to(() => const AddItemsScreen()),
                child: Container(
                  height: 192,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/rating.jpg'),
                      opacity: 0.5,
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0.8],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        mc.switchBool.value ? 'Rate a Movie' : 'Rate a Book',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  SubItem(
                    itemTitle: mc.switchBool.value ? 'All Movies' : 'All Books',
                    screenName: const AllItemsScreen(),
                    bgImage: mc.switchBool.value
                        ? 'assets/all_movies.jpg'
                        : 'assets/all_books.jpg',
                  ),
                  const SizedBox(width: 16),
                  SubItem(
                    itemTitle: mc.switchBool.value
                        ? 'Favourite Movies'
                        : 'Favourite Books',
                    screenName: const FavouriteScreen(),
                    bgImage: mc.switchBool.value
                        ? 'assets/fav_movies.jpg'
                        : 'assets/fav_books.jpg',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SubItem extends StatelessWidget {
  const SubItem({
    super.key,
    required this.itemTitle,
    required this.screenName,
    required this.bgImage,
  });

  final String itemTitle;
  final Widget screenName;
  final String bgImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => Get.to(() => screenName),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              image: DecorationImage(
                image: AssetImage(bgImage),
                opacity: 0.5,
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.8],
              ),
            ),
            child: Text(
              itemTitle,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                height: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

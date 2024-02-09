import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:critiq/controllers/books_api_controller.dart';

class FindItems extends StatelessWidget {
  const FindItems({super.key});

  @override
  Widget build(BuildContext context) {
    final BooksAPIController bc = Get.put(BooksAPIController());

    return Column(
      children: [
        SearchBar(
          leading: const Icon(Icons.search),
          elevation: const MaterialStatePropertyAll(2),
          hintText: 'Enter Book Name',
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          onSubmitted: (value) {
            bc.itemName.value = value;
            bc.isSearched.value = true;
          },
        ),
        const SizedBox(height: 24),
        Expanded(
          child: FutureBuilder(
              future: bc.fetchBooks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      'Search for a book,\nand tap on it to continue!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'No books found.\nSearch for another book.',
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
                            onTap: null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(data['volumeInfo']['imageLinks']
                                    ['thumbnail']),
                                const SizedBox(height: 16),
                                Text(
                                  data['volumeInfo']['title'].toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              }),
        ),
      ],
    );
  }
}

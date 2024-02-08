class Item {
  int? id;
  final String title;
  final double initialResponseRating;
  final double recommendationRating;
  final double rewatchabilityRating;
  final double plotRating;
  final double characterRating;
  final double endingRating;
  final double rating;
  final bool type;

  Item({
    this.id,
    required this.title,
    required this.initialResponseRating,
    required this.recommendationRating,
    required this.rewatchabilityRating,
    required this.characterRating,
    required this.plotRating,
    required this.endingRating,
    required this.rating,
    required this.type,
  });

  // Below function is used to convert the map to the item object
  Item.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        title = item["title"],
        characterRating = item["characterRating"].toDouble(),
        endingRating = item["endingRating"].toDouble(),
        initialResponseRating = item["initialResponseRating"].toDouble(),
        plotRating = item["plotRating"].toDouble(),
        recommendationRating = item["recommendationRating"].toDouble(),
        rewatchabilityRating = item["rewatchabilityRating"].toDouble(),
        rating = item["rating"].toDouble(),
        type = item["type"] == "true" ? true : false;

  // Below function is used to convert the item object to the map for the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'characterRating': characterRating,
      'endingRating': endingRating,
      'initialResponseRating': initialResponseRating,
      'plotRating': plotRating,
      'recommendationRating': recommendationRating,
      'rewatchabilityRating': rewatchabilityRating,
      'rating': rating,
      'type': type,
    };
  }
}

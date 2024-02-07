class Item {
  final int id;
  final String title;
  final double initialResponseRating;
  final double recommendationRating;
  final double rewatchabilityRating;
  final double plotRating;
  final double characterRating;
  final double endingRating;
  final double rating;

  Item({
    required this.id,
    required this.title,
    required this.initialResponseRating,
    required this.recommendationRating,
    required this.rewatchabilityRating,
    required this.characterRating,
    required this.plotRating,
    required this.endingRating,
    required this.rating,
  });

  Item.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        title = item["title"],
        characterRating = item["characterRating"],
        endingRating = item["endingRating"],
        initialResponseRating = item["initialResponseRating"],
        plotRating = item["plotRating"],
        recommendationRating = item["recommendationRating"],
        rewatchabilityRating = item["rewatchabilityRating"],
        rating = item["rating"];

  Map<String, Object> toMap() {
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
    };
  }
}

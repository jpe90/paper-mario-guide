import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());
enum Level { whisperingWoods, toadTown }

enum Category { toad, box, hole, collect }

Category getCategoryFromString(String categoryAsString) {
  switch (categoryAsString) {
    case "toad":
      return Category.toad;
      break;
    case "box":
      return Category.box;
      break;
    case "hole":
      return Category.hole;
      break;
    case "collect":
      return Category.collect;
      break;
    default:
      return null;
      break;
  }
}

Level getLevelFromString(String levelAsString) {
  switch (levelAsString) {
    case "toadTown":
      return Level.toadTown;
      break;
    case "whisperingWoods":
      return Level.whisperingWoods;
      break;
    default:
      return null;
      break;
  }
}

class Collectible {
  Collectible({
    @required this.id,
    @required this.level,
    @required this.category,
    this.notes,
    this.description,
  })  : assert(id != null),
        assert(level != null),
        assert(category != null);

  final int id;
  final Level level;
  final Category category;
  final String description;
  final String notes;

  factory Collectible.fromJson(Map<String, dynamic> json) {
    //logger.d(json.toString());
    return Collectible(
        id: json["id"],
        level: getLevelFromString(json["level"]),
        category: getCategoryFromString(json["category"]),
        notes: json["notes"]);
  }
  String get thumbnailAssetName => 'assets/thumbnails/$id.jpg';
  String get fullAssetName => 'assets/full/$id.jpg';
  bool get hasNotes => notes != null;
  // String get assetName => '$id.jpg';

  String toString() =>
      'id: $id, level: $level, category: $category, notes: $notes, description: $description';
}

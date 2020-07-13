import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());
enum Level { whisperingWoods, toadTown }
enum Category { toad, box, hole, treasure }

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
  static final Map<Level, String> _levelDisplayNameMap =
      _buildLevelDisplayNameMap();
  static final Map<Category, String> _categoryDisplayNameMap =
      _buildCategoryDisplayNameMap();

  factory Collectible.fromJson(Map<String, dynamic> json) {
    return Collectible(
        id: json["id"],
        level: getLevelFromString(json["level"]),
        category: getCategoryFromString(json["category"]),
        notes: json["notes"]);
  }

  String get thumbnailAssetName => 'assets/thumbnails/$id.jpg';
  String get fullAssetName => 'assets/full/$id.jpg';
  bool get hasNotes => notes != null;

  String toString() =>
      'id: $id, level: $level, category: $category, notes: $notes, description: $description';

  //overly verbose horseshit
  static String getDisplayNameForLevel(Level level) {
    return _levelDisplayNameMap[level];
  }

  static String getDisplayNameForCategory(Category category) {
    return _categoryDisplayNameMap[category];
  }

  static Map<Level, String> _buildLevelDisplayNameMap() {
    return {
      Level.toadTown: "Toad Town",
      Level.whisperingWoods: "WhisperingWoods"
    };
  }

  static Map<Category, String> _buildCategoryDisplayNameMap() {
    return {
      Category.toad: "Toad",
      Category.box: "? Box",
      Category.hole: "Hole",
      Category.treasure: "Treasure"
    };
  }

  static Level getLevelFromString(String levelAsString) {
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

  static Category getCategoryFromString(String categoryAsString) {
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
      case "treasure":
        return Category.treasure;
        break;
      default:
        return null;
        break;
    }
  }
}

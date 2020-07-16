import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());
enum Level {
  all,
  whisperingWoods,
  toadTown,
}
enum Category { all, toad, box, hole, treasure }
enum CompletionStatus { all, completed, notCompleted }

class Collectible {
  const Collectible({
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
    switch (level) {
      case Level.whisperingWoods:
        return "Whispering Woods";
        break;
      case Level.toadTown:
        return "Toad Town";
        break;
      default:
        return "All";
        break;
    }
  }

  static String getDisplayNameForCategory(Category category) {
    switch (category) {
      case Category.box:
        return "? Box";
        break;
      case Category.toad:
        return "Toad";
        break;
      case Category.hole:
        return "Hole";
        break;
      case Category.treasure:
        return "Treasure";
        break;
      default:
        return "All";
        break;
    }
  }

  static String getDisplayNameForCompletionStatus(CompletionStatus status) {
    switch (status) {
      case CompletionStatus.completed:
        return "Only Completed";
        break;
      case CompletionStatus.notCompleted:
        return "Not Completed";
        break;
      default:
        return "All";
        break;
    }
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

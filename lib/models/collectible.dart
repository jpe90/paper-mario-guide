import 'package:meta/meta.dart';

import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());
enum Level {
  all,
  whisperingWoods,
  toadTown,
  graffitiUnderground,
  picnicRoad,
  overlookMountain,
  earthVellumental,
  overlookTower,
  //autumnMountain,
  //chestnutValley,
  //waterVellumental,
  //eddyRiver
}
enum Category { all, toad, box, hole, treasure }
enum CompletionStatus { all, completed, notCompleted }

class Collectible {
  const Collectible({
    @required this.id,
    @required this.level,
    @required this.category,
    this.numItems = 1,
    this.order,
    this.notes,
  })  : assert(id != null),
        assert(level != null),
        assert(category != null),
        assert(numItems != null);

  final int id;
  final Level level;
  final Category category;
  final String notes;
  final int order;
  final numItems;

  factory Collectible.fromJson(Map<String, dynamic> json) {
    return Collectible(
        id: json["id"],
        level: getLevelFromString(json["level"]),
        category: getCategoryFromString(json["category"]),
        notes: json["notes"],
        order: json["order"],
        numItems: json["numItems"]);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'level': getEncodingNameForLevel(level),
        'category': getEncodingNameForCategory(category),
        'order': order,
        'numItems': numItems,
        if (notes != null) 'notes': notes
      };

  String get fullAssetName => 'assets/images/$id.jpg';
  bool get hasNotes => notes != null;

  String toString() =>
      'id: $id, level: $level, category: $category, notes: $notes, order: $order ';

  //overly verbose horseshit

  static String getDisplayNameForLevel(Level level) {
    switch (level) {
      case Level.whisperingWoods:
        return "Whispering Woods";
        break;
      case Level.toadTown:
        return "Toad Town";
        break;
      case Level.graffitiUnderground:
        return "Graffiti Underground";
        break;
      case Level.picnicRoad:
        return "Picnic Road";
        break;
      case Level.overlookMountain:
        return "Overlook Mountain";
        break;
      case Level.earthVellumental:
        return "Earth Ellumental Temple";
        break;
      case Level.overlookTower:
        return "Overlook Tower";
        break;
      //case Level.autumnMountain:
      //  return "Autumn Mountain";
      //  break;
      //case Level.chestnutValley:
      //  return "Chestnut Valley";
      //  break;
      //case Level.waterVellumental:
      //  return "Water Vellumental Shrine";
      //  break;
      //case Level.eddyRiver:
      //  return "Eddy River";
      //  break;
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

  static getStatusFromBool(bool muhBool) {
    return muhBool ? CompletionStatus.completed : CompletionStatus.notCompleted;
  }

  static getBoolFromCompletionStatus(CompletionStatus status) {
    return status == CompletionStatus.completed ? true : false;
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
      case "graffitiUnderground":
        return Level.graffitiUnderground;
        break;
      case "picnicRoad":
        return Level.picnicRoad;
        break;
      case "overlookMountain":
        return Level.overlookMountain;
        break;
      case "earthVellumental":
        return Level.earthVellumental;
        break;
      case "overlookTower":
        return Level.overlookTower;
        break;
      //case "autumnMountain":
      //  return Level.autumnMountain;
      //  break;
      //case "chestnutValley":
      //  return Level.chestnutValley;
      //  break;
      //case "waterVellumental":
      //  return Level.waterVellumental;
      //  break;
      //case "eddyRiver":
      //  return Level.eddyRiver;
      //  break;
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

  static String getEncodingNameForCategory(Category category) {
    switch (category) {
      case Category.toad:
        return "toad";
        break;
      case Category.box:
        return "box";
        break;
      case Category.hole:
        return "hole";
        break;
      case Category.treasure:
        return "treasure";
        break;
      default:
        return null;
        break;
    }
  }

  static String getEncodingNameForLevel(Level level) {
    switch (level) {
      case Level.toadTown:
        return "toadTown";
        break;
      case Level.whisperingWoods:
        return "whisperingWoods";
        break;
      case Level.graffitiUnderground:
        return "graffitiUnderground";
        break;
      case Level.picnicRoad:
        return "picnicRoad";
        break;
      case Level.overlookMountain:
        return "overlookMountain";
        break;
      case Level.earthVellumental:
        return "earthVellumental";
        break;
      case Level.overlookTower:
        return "overlookTower";
        break;
      //case Level.autumnMountain:
      //  return "autumnMountain";
      //  break;
      //case Level.chestnutValley:
      //  return "chestnutValley";
      //  break;
      //case Level.waterVellumental:
      //  return "waterVellumental";
      //  break;
      //case Level.eddyRiver:
      //  return "eddyRiver";
      //  break;
      default:
        return null;
        break;
    }
  }
}

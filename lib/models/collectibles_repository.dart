import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart' as l;

import '../models/collectible.dart';

class CollectiblesRepository {
  //GridModelService() : _logger = Logger(printer: PrettyPrinter());
  //var _logger;
  static const jsonDataFile = 'data/collectibles.json';
  CollectiblesRepository();
  static List<Collectible> collectibles = [];

  Future<String> readJsonData() async {
    try {
      return await rootBundle.loadString(jsonDataFile);
    } catch (e) {
      throw Exception('Exception in readJsonData: $e');
    }
  }

  Future<List<Collectible>> loadCollectiblesFromJson() async {
    try {
      String jsonString = await readJsonData();
      Iterable dynamicJsonList = jsonDecode(jsonString);
      List<Collectible> collectibles =
          List.from(dynamicJsonList.map((item) => Collectible.fromJson(item)));
      return collectibles;
    } catch (e) {
      throw Exception('Exception in getAllCollectibles : $e');
    }
  }

  List<Collectible> getFilteredCollectibles(
      Category category, Level level, CompletionStatus status) {
    return collectibles.where((element) {
      return (category == Category.all || category == element.category) &&
          (level == Level.all || level == element.level) &&
          (status == CompletionStatus.all ||
              status == element.completionStatus);
    }).toList();
  }
}

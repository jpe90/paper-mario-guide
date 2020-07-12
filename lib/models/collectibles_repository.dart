import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
//import 'package:logger/logger.dart';

import '../models/collectible.dart';

class CollectiblesRepository {
  //GridModelService() : _logger = Logger(printer: PrettyPrinter());
  //var _logger;
  static const jsonDataFile = 'data/collectibles.json';
  CollectiblesRepository() : collectibles = [];
  List<Collectible> collectibles;

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
}

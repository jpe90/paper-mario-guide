import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../lib/models/collectible.dart';

writeCollectiblesJsonToFile(String path) {
  List<Collectible> muhCollectibles = [];
  String json = jsonEncode(muhCollectibles);
  print(json);
  new File(path).writeAsString(json);
}

List<Collectible> createCollectibleListForLevel(
    {Level level,
    int startingId,
    int numHoles,
    int numToads,
    int numBoxes,
    int numTreasures}) {
  return createCollectibleList(
          level: level,
          category: Category.hole,
          startingId: startingId,
          numEntries: numHoles) +
      createCollectibleList(
          level: level,
          category: Category.toad,
          startingId: startingId + numHoles,
          numEntries: numToads) +
      createCollectibleList(
          level: level,
          category: Category.box,
          startingId: startingId + numHoles + numToads,
          numEntries: numBoxes) +
      createCollectibleList(
          level: level,
          category: Category.treasure,
          startingId: startingId + numHoles + numToads + numBoxes,
          numEntries: numTreasures);
}

List<Collectible> createCollectibleList(
    {Level level, Category category, int startingId, int numEntries}) {
  List<Collectible> retList = [];
  for (var i = startingId; i < startingId + numEntries; i++) {
    retList.add(Collectible(
        id: i, order: i - startingId, level: level, category: category));
  }
  //retList.forEach(print);
  return retList;
}

void main() {
  writeCollectiblesJsonToFile("muhJson.json");
}

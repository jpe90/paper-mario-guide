import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../lib/models/collectible.dart';

writeCollectiblesJsonToFile(String path) {
  //List<Collectible> muhCollectibles = [];
  List<Collectible> muhCollectibles = createCollectiblesJson();
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String json = encoder.convert(muhCollectibles);
  print(json);
  new File(path).writeAsString(json);
}

List<Collectible> createCollectiblesJson() {
  List<Collectible> whisperingWoods = createCollectibleListForLevel(
      level: Level.whisperingWoods,
      startingId: 0,
      numHoles: 25,
      numToads: 12,
      numBoxes: 10,
      numTreasures: 3);

  List<Collectible> toadTown = createCollectibleListForLevel(
      level: Level.toadTown,
      startingId: 50,
      numHoles: 16,
      numToads: 1,
      numBoxes: 9,
      numTreasures: 13);

  return whisperingWoods + toadTown;
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

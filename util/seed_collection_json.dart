import 'dart:convert';
import 'dart:io';
import '../lib/models/collectible.dart';

Map<int, String> notesMap = {1: "this is a test note"};

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
      numTreasures: 11);

  List<Collectible> graffitiUnderground = createCollectibleListForLevel(
      level: Level.graffitiUnderground,
      startingId: 87,
      numHoles: 5,
      numToads: 2,
      numBoxes: 2,
      numTreasures: 1);

  List<Collectible> picnicRoad = createCollectibleListForLevel(
      level: Level.picnicRoad,
      startingId: 97,
      numHoles: 17,
      numToads: 58,
      numBoxes: 7,
      numTreasures: 3);

  List<Collectible> overlookMountain = createCollectibleListForLevel(
      level: Level.overlookMountain,
      startingId: 182,
      numHoles: 19,
      numToads: 36,
      numBoxes: 9,
      numTreasures: 5);

  List<Collectible> earthVelumental = createCollectibleListForLevel(
      level: Level.earthVellumental,
      startingId: 251,
      numHoles: 11,
      numToads: 7,
      numBoxes: 12,
      numTreasures: 3);

  List<Collectible> overlookTower = createCollectibleListForLevel(
      level: Level.overlookTower,
      startingId: 284,
      numHoles: 3,
      numToads: 20,
      numBoxes: 1,
      numTreasures: 2);

  return whisperingWoods +
      toadTown +
      graffitiUnderground +
      picnicRoad +
      overlookMountain +
      earthVelumental +
      overlookTower;
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

// TODO Enhancement 1: take in order here
List<Collectible> createCollectibleList(
    {Level level, Category category, int startingId, int numEntries}) {
  List<Collectible> retList = [];
  // TODO enhancement 1: should bookkeep for order field inside this loop
  for (var i = startingId; i < startingId + numEntries; i++) {
    retList.add(notesMap[i] == null
        ? Collectible(
            id: i, order: i - startingId, level: level, category: category)
        : Collectible(
            id: i,
            order: i - startingId,
            level: level,
            category: category,
            notes: notesMap[i]));
  }
  //retList.forEach(print);
  return retList;
}

void main() {
  writeCollectiblesJsonToFile("muhJson.json");
}

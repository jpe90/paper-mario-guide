import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../lib/models/collectible.dart';

writeCollectiblesJsonToFile(String path) {
  List<Collectible> muhCollectibles =
      createCollectibleList(Level.toadTown, Category.box, 10, 10);
  String json = jsonEncode(muhCollectibles);
  print(json);
  new File(path).writeAsString(json);
}

List<Collectible> createCollectibleList(
    Level level, Category category, int startingId, int numEntries) {
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

import 'dart:convert';
import 'dart:io';
import '../lib/models/collectible.dart';

const List<int> blacklist = [
  49,
  80,
  81,
  82,
  83,
  84,
  85,
  86,
  137,
  138,
  139,
  140,
  141,
  145,
  146,
  147,
  155,
  156,
  157,
  158,
  159,
  160,
  161,
  162,
  163,
  167,
  168,
  169,
  185,
  194,
  219,
  220,
  221,
  222,
  223,
  224,
  225,
  226,
  227,
  309
];
const Map<int, String> notesMap = {
  27: "Hit the bug to reveal a toad.",
  29: "Hit the bug to reveal a toad.",
  31: "Hit the eggs on the plate  to reveal a toad.",
  34: "Jump below the flower pot and hit the flower that appears to reveal a toad.",
  39: "Complete the matching minigame to get an invincibility star. Run to the left to a patch of spikes and jump on a patch of grass in the spikes.",
  49: "Complete the matching minigame to get an invincibility star. Use it to run over the spikes blocking the chest.",
  65: "Available after the red streamer has been destroyed. Toad will greet you outside a house in Toad Town.",
  66: "Hit the tower with your hammer and battle the Goomba that falls out. Use the magic circle to reveal a toad.",
  72: "Hit the floor in front of the shelf to reveal a ? box.",
  73: "Hit the green roller in the back room of the red building to move it against the shelf to get on top of it.",
  74: "Stairs leading down to the ? box are off screen to the left.",
  76: "Found through a hidden tunnel to the left of a house with a red mushroom roof.",
  77: "Found by walking through a house with green origami.",
  78: "Defeat the giant Goomba on the roof of the large building.",
  79: "After defeating the colored pencils, walk behind the red building to get to a pier. Hit the barrel with your hammer and purchase the treasure from the mole.",
  89: "Hidden passage to the right of the green warp pipe.",
  90: "Hit the crate to reveal a toad.",
  95: "Hidden passage to the right of the green warp pipe.",
  116: "Hit the wall below the hole until a toad pops out.",
  117: "Hit the yellow origami flower to reveal a toad.",
  118: "Hit the hole to reveal a toad.",
  123: "Hit the back of the sign to reveal a toad.",
  124: "Hit the hidden blocks, and then hit the origami duck to reveal a toad.",
  126: "Hit the origami butterfly to reveal a toad.",
  127:
      "Hit the mailbox and then the mail that falls out to reveal three toads.",
  128:
      "Hit the mailbox and then the mail that falls out to reveal three toads.",
  129:
      "Hit the mailbox and then the mail that falls out to reveal three toads.",
  130: "Hit the tree to reveal a toad",
  131:
      "Fill the hole with confetti and then hit the butterfly to reveal a toad.",
  133: "Hit the red origami flower to reveal a toad.",
  134: "Hit the hole to reveal a toad",
  135:
      "Hit the green blocks by the flagpoe to raise a staircase, then jump on the flag to reveal 7 toads.",
  136:
      "Hit the green blocks by the flagpoe to raise a staircase, then jump on the flag to reveal 7 toads.",
  137:
      "Hit the green blocks by the flagpoe to raise a staircase, then jump on the flag to reveal 7 toads.",
  138:
      "Hit the green blocks by the flagpoe to raise a staircase, then jump on the flag to reveal 7 toads.",
  139:
      "Hit the green blocks by the flagpoe to raise a staircase, then jump on the flag to reveal 7 toads.",
  140:
      "Hit the green blocks by the flagpoe to raise a staircase, then jump on the flag to reveal 7 toads.",
  141:
      "Hit the green blocks by the flagpoe to raise a staircase, then jump on the flag to reveal 7 toads.",
  142:
      "Jump on the flag again to lower it to the ground, and then hit it with your hammer to reveal a toad.",
  143: "Hit the hole to reveal a toad",
  144: "Hit the wall below the hole until four toads pop out.",
  145: "Hit the wall below the hole until four toads pop out.",
  146: "Hit the wall below the hole until four toads pop out.",
  147: "Hit the wall below the hole until four toads pop out.",
  148: "Hit the tree to reveal a toad.",
  149:
      "Drop down to the right after toad 35. Hit all but the two bottom holes and then hit the origami gopher to reveal a toad.",
  150: "Hit the origami dog to reveal a toad.",
  151:
      "Hit the yellow umbrella to expand it and drop down on top of it from the top of the stairs to reach the toad.",
  153:
      "Drop down the steps in front of the temple and hit the cracked box to access a hidden pathway. Go right to reach the toad.",
  154:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  155:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  156:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  157:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  158:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  159:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  160:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  161:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  162:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  163:
      "Hit the broken block to reveal a magic circle. Use the magic circle to free 10 toads.",
  164: "Hit a hidden toad to the right of the window with your hammer.",
  165:
      "After defeating the Earth Vellumental, hit the origami mushroom to reveal a toad.",
  166:
      "After rescuing the popcorn vendor toad from the Earth Vellumemental Temple, speak to him and pay 100 coins to rescue 4 toads.",
  170:
      "After defeating the colored pencils, hit the back of the sign at the sensor lab to reveal a toad.",
  171:
      "After defeating the colored pencils, hit the computer inside the sensor lab to reveal a toad.",
  173:
      "Enter a cave near the four toads behind the white fence to reach this ? box.",
  177: "Jump at the tip of the arrow made of coins to reveal a hidden ? box.",
  179:
      "Defeat the Earth Vellumental to be able to buy this treasure from the item shop outside the temple.",
  180:
      "Defeat the Earth Vellumental to be able to buy this treasure from the item shop outside the temple.",
  181:
      "After defeating the colored pencils, walk to the right of the sensor lab to find a treasure chest.",
  200: "After defeating the colored pencils, return to the tram.",
  201: "Hit the sign.",
  204: "Hit the grasshopper to reveal a toad.",
  205: "Hit the grasshopper to reveal a toad.",
  206: "Hit the grasshopper to reveal a toad.",
  207: "Hit the beetle to reveal a toad.",
  208: "Destroy the rock behind the warp pipe to reveal a toad.",
  228: "Hit the back of the sign.",
  230: "The ? box contains a toad.",
  232: "Defeat the three large goombas to reveal three toads.",
  233: "Defeat the three large goombas to reveal three toads.",
  234: "Defeat the three large goombas to reveal three toads.",
  235:
      "After rescuing a toad whom is chased off by a Goomba, find the terrorized toad by the warp pipe.",
  236:
      "After defeating the colored pencils, jump under the flower pot to reveal a toad.",
  246: "Walk left at the entrance to Overlook Mountain to find a chest.",
  247: "There is a hidden path to the back/left of the Auctioneer Mole.",
  248: "There is a hidden path by the fishing pier.",
  249:
      "Walk towards the screen where the giant Shy Guys were kicking the shell stone.",
  262: "Hit the rock behind the red box to reveal a bug. Hit it.",
  264: "Jump underneath the second light from the left to reveal a toad.",
  265:
      "After destroying a cracked rock at the end of the path, three bugs will scatter. One hides beneath this staircase.",
  266:
      "After destroying a cracked rock at the end of the path, three bugs will scatter. Two remain in the room.",
  267:
      "After destroying a cracked rock at the end of the path, three bugs will scatter. Two remain in the room.",
  268:
      "In the main temple room, there is a hidden path to the left of a pillar that moves up and down. Go to the end to find a toad.",
  269: "Jump to the left of the red box to reveal a hidden ? box.",
  270:
      "Jump to the right of the torch after breaking down a wall to reveal a hidden ? box.",
  276:
      "Drop down below the pillars that slide out and jump to the right of a torch to reveal a ? box.",
  277: "Jump on top of ? box #8 to reveal another hidden ? box.",
  279:
      "Jump in front of a turtle statue to the left of the boss room to reveal a hidden ? box.",
  280: "Jump to the right of box #11 to reveal another hidden ? box.",
  283: "Hit ? box #9 to reveal a treasure.",
  287: "Press the elevator button.",
  288: "Hit the postcards to reveal a toad.",
  289: "Hit the leftmost flag to reveal a toad.",
  290: "Hit the three origami triangles.",
  291: "Hit the three origami triangles.",
  292: "Hit the three origami triangles.",
  293: "Hit the bucket and the paper toads that fall out.",
  294: "Hit the bucket and the paper toads that fall out.",
  295: "Hit the bucket and the paper toads that fall out.",
  296:
      "Hit the hidden block to the left of the toad to get up to the sticker on the wall. Remove it to reveal a toad.",
  297: "Open the cupboard to reveal a toad.",
  298: "Hit the trash can to reveal a toad.",
  299: "Hit the omelette to reveal a toad.",
  300: "Hit the drawer to reveal a toad.",
  303:
      "Talk to the Chef after getting rid of the Goombas in the kitchen and restaraunt.",
  304: "Hit the yellow colored pencil.",
  305: "After defeating the colored pencils, hit the telescope.",
  307:
      "After defeating the colored pencils, talk to the toad at the Overlook Mountain tram, and then speak to the chef in the Overlook Tower kitchen.",
  308:
      "After defeating the colored pencils, talk to the toad at the Overlook Mountain tram, and then speak to the toad at the Overlook Tower coffee shop."
};

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
    if (!blacklist.contains(i)) {
      retList.add(notesMap[i] == null
          ? Collectible(
              id: i,
              order: i - startingId + 1,
              level: level,
              category: category)
          : Collectible(
              id: i,
              order: i - startingId + 1,
              level: level,
              category: category,
              notes: notesMap[i]));
    }
  }
  //retList.forEach(print);
  return retList;
}

void main() {
  writeCollectiblesJsonToFile("muhJson.json");
}

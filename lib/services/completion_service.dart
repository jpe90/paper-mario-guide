import 'package:origami_king_guide/models/collectible.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class is intended to abstract getting and setting completion values of collectibles, because
// we're keeping that logic out of the collectibles class

// persisting data:
// make a map of int to bool
class CollectiblesCompletionService {
  SharedPreferences prefs;
  Map<int, bool> _completionMap = {};

  createMap(List<Collectible> collectibles) {
    if (prefs == null) {
      throw Exception("Illegal state: Shared prefs should not be null");
    }
    collectibles.forEach((collectible) {
      _completionMap.putIfAbsent(collectible.id,
          () => prefs.getBool(collectible.id.toString()) ?? false);
    });
  }

  // this needs to be in a separate method because initState can't be marked async
  //
  Future<void> loadCompletionFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs == null) {
      throw Exception("Shared prefs encountered an error");
    }
  }

  bool getCompletionStatusForId(int id) {
    //bool muhBool = prefs.getBool(id.toString()) ?? false;
    //logger.d("in getCompletionStatus callback returning $muhBool");
    //return muhBool;
    if (!_completionMap.containsKey(id)) {
      throw ArgumentError("id not present");
    }
    return _completionMap[id];
  }

  void updateCompletionStatusForId(int id, bool newStatus) {
    if (!_completionMap.containsKey(id)) {
      throw ArgumentError("id not present");
    }
    _completionMap[id] = newStatus;
    prefs.setBool(id.toString(), newStatus);
  }
}

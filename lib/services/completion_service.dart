import 'package:origami_king_guide/models/collectible.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletionService {
  SharedPreferences prefs;

  List<Collectible> getFilteredCollectibles(List<Collectible> collectibles,
      Category category, Level level, CompletionStatus completionStatus) {
    return collectibles.where((element) {
      return (category == Category.all || category == element.category) &&
          (level == Level.all || level == element.level) &&
          (completionStatus == CompletionStatus.all ||
              prefs.getBool(element.id.toString()) ==
                  Collectible.getBoolFromCompletionStatus(completionStatus));
    }).toList();
  }

  // this needs to be in a separate method because initState can't be marked async
  Future<bool> loadCompletionFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs == null) {
      return false;
    }
    return true;
  }
}

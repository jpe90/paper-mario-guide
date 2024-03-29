import 'package:flutter/material.dart';
import 'package:origami_king_guide/services/admob_service.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:collection/collection.dart';
import '../widgets/card_bottom.dart';
import '../models/collectible.dart';

import 'package:logger/logger.dart' as l;

class CollectiblesView extends StatelessWidget {
  final List<Collectible> collectibles;
  final bool Function(int id) getCompletionStatus;
  final void Function(int id, bool status) onCheckboxChanged;

  const CollectiblesView(
      {@required this.collectibles,
      @required this.onCheckboxChanged,
      @required this.getCompletionStatus})
      : assert(onCheckboxChanged != null),
        assert(getCompletionStatus != null);

// on tap for lil' hero
  Scaffold collectibleDetailsPage(
      Collectible collectible, BuildContext context, String title) {
    bool hasNotes = collectible.notes != null;
    return Scaffold(
      //TODO: change this app bar text
      appBar: AppBar(title: Text('')),
      body: Material(
        elevation: 8.0,
        child: ListView(
          children: [
            CollectibleImageHero(
              collectible: collectible,
              onTap: () => Navigator.of(context).pop(),
              fit: BoxFit.fitHeight,
            ),
            CardBottom(
              title: title,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              value: getCompletionStatus(collectible.id),
              onChanged: (complete) {
                onCheckboxChanged(collectible.id, complete);
              },
              descr: collectible.notes,
            ),
          ],
        ),
      ),
    );
  }

  Card _gridElement(Collectible collectible, BuildContext context) {
    String title = collectible.numItems == 1
        ? '${Collectible.getDisplayNameForCategory(collectible.category)} #${collectible.order}'
        : '${Collectible.getDisplayNameForCategory(collectible.category)}s #${collectible.order} - ${collectible.order + collectible.numItems - 1}';
    return Card(
      elevation: 8.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: [
          CollectibleImageHero(
            collectible: collectible,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      collectibleDetailsPage(collectible, context, title)));
            },
          ),
          CardBottom(
            title: title,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            value: getCompletionStatus(collectible.id),
            onChanged: (complete) {
              onCheckboxChanged(collectible.id, complete);
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  SliverGrid collectiblesGrid(
      BuildContext context, List<Collectible> gridCollectibles) {
    return SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        //childAspectRatio: 2.0 / 1.8,
        children: gridCollectibles
            .map((collectible) => _gridElement(collectible, context))
            .toList());
  }

  Widget _getScrollView(BuildContext context, List<Collectible> _collectibles) {
    List<Widget> slivers = [];
    Map<Level, List<Collectible>> muhMap =
        groupBy(_collectibles, (collectible) => collectible.level);
    muhMap.forEach(
        (lvl, lst) => slivers.add(_getSliversForLevel(context, lvl, lst)));
    return CustomScrollView(
      slivers: slivers,
    );
  }

  SliverStickyHeader _getSliversForLevel(
      //List<Widget> _getSliversForLevel(
      BuildContext context,
      Level level,
      List<Collectible> _collectibles) {
    return SliverStickyHeader(
      header: Container(
        alignment: Alignment.center,
        height: 35.0,
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(Collectible.getDisplayNameForLevel(level),
              style: TextStyle(fontSize: 14)),
        ),
      ),
      sliver: collectiblesGrid(context, _collectibles),
    );
  }

  Center emptyMessage(BuildContext context) {
    return Center(
      child: Text('No items match your selected filter criteria.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: collectibles.isEmpty
              ? Center(child: emptyMessage(context))
              : _getScrollView(context, collectibles),
        ),
        AdmobService.admobBanner,
      ],
    );
  }
}

// TODO: this should be in a different file
class CollectibleImageHero extends StatelessWidget {
  const CollectibleImageHero({
    this.collectible,
    this.onTap,
    this.fit,
    Key key,
  }) : super(key: key);

  final Collectible collectible;
  final VoidCallback onTap;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: collectible.id,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Image(
              image: AssetImage(collectible.fullAssetName),
              fit: fit ?? BoxFit.fitWidth),
        ),
      ),
    );
  }
}

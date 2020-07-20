import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:origami_king_guide/services/admob_service.dart';

import '../widgets/card_bottom.dart';
import '../models/collectible.dart';

import 'package:logger/logger.dart' as l;

class CollectiblesView extends StatelessWidget {
  final List<Collectible> collectibles;
  final void Function(Collectible collectible, CompletionStatus status)
      onCheckboxChanged;

  const CollectiblesView(
      {@required this.collectibles, @required this.onCheckboxChanged})
      : assert(onCheckboxChanged != null);

// on tap for lil' hero
  Widget collectibleDetailsPage(Collectible collectible, BuildContext context) {
    bool hasNotes = collectible.notes != null;
    return Scaffold(
      appBar: AppBar(title: Text('Testing Hero')),
      body: Material(
        elevation: 8.0,
        child: Column(
          mainAxisAlignment:
              hasNotes ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: CollectibleImageHero(
                collectible: collectible,
                onTap: () => Navigator.of(context).pop(),
                fit: BoxFit.fitHeight,
              ),
            ),
            Flexible(
              flex: 1,
              fit: hasNotes ? FlexFit.tight : FlexFit.loose,
              child: CardBottom(
                id: collectible.id,
                categoryName:
                    Collectible.getDisplayNameForCategory(collectible.category),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: Collectible.getBoolFromCompletionStatus(
                    collectible.completionStatus),
                onChanged: (complete) {
                  onCheckboxChanged(
                      collectible, Collectible.getStatusFromBool(complete));
                },
                descr: collectible.notes,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridElement(Collectible collectible, BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Column(
        children: [
          CollectibleImageHero(
            collectible: collectible,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      collectibleDetailsPage(collectible, context)));
            },
          ),
          CardBottom(
            id: collectible.id,
            categoryName:
                Collectible.getDisplayNameForCategory(collectible.category),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            value: Collectible.getBoolFromCompletionStatus(
                collectible.completionStatus),
            onChanged: (complete) {
              onCheckboxChanged(
                  collectible, Collectible.getStatusFromBool(complete));
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget collectiblesGrid(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 2.0 / 1.8,
        children: collectibles
            .map((collectible) => _gridElement(collectible, context))
            .toList());
  }

  Widget emptyMessage(BuildContext context) {
    return Center(
      child: Text('No items match your selected filter criteria.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var admobBanner = AdmobBanner(
        adUnitId: AdmobService.getBannerAdId(),
        adSize: AdmobBannerSize.FULL_BANNER);
    return collectibles.isEmpty
        ? Center(child: admobBanner)
        : collectiblesGrid(context);
    // return collectibles.isEmpty
    //     ? emptyMessage(context)
    //     : collectiblesGrid(context);
  }
}

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
